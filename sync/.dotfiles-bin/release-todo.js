#!/usr/bin/env node

const { basename, relative } = require("path")

const usage = () => `
  node ${relative(process.cwd(), __filename)} [flags]

  Copies the release process checklist to a GitHub issue, optionally updating the
  version and date of the instructions.
  
  Flags: [--create] [--update[=<issue-num>]] [--date=<YYYY-MM-DD>] [--version=X.Y.Z]

  [--create] (default: true)
  By default this will create a new issue in the repo.

  [--update[=<issue-num>]]
  Update a specific issue number, or if set without a value it will update the most
  recent issue created with the default tag.

  [--tag=<tag>] (default: "release-manager")
  Issues will be created and looked up with this tag.

  [--version=X.Y.Z]
  This script can be run before the next version number is known and then rerun
  with this flag to update the checklist with the correct version number.
  
  [--date=<YYYY-MM-DD>] (default: ${date()})
  Set the date of the release in the release process checklist.
`

const execSync = (...args) =>
  require("child_process")
    .execSync(...args)
    .toString()
    .trim()

const get = url =>
  new Promise((resolve, reject) => {
    require("https")
      .get(url, resp => {
        let d = ""
        resp.on("data", c => (d += c))
        resp.on("end", () => resolve(d))
      })
      .on("error", reject)
  })

const date = (d = new Date()) => {
  const pad = s => s.toString().padStart(2, "0")
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`
}

const replaceAll = (str, rep) =>
  Object.entries(rep).reduce(
    (a, [k, v]) => a.replace(new RegExp(k, "g"), v),
    str
  )

const ghIssue = args => {
  const repo = `-R "${args.repo}"`
  const label = `-l "${args.label}"`
  const assignee = `-a "${args.assignee}"`
  const title = `-t "${args.title}"`
  const json = "--json body,title,number"
  const body = "-F -"

  const issue = (a, options) =>
    execSync(["gh issue", args.command, repo, ...a].join(" "), options)

  switch (args.command) {
    case "list":
      // get the first matching issue
      return JSON.parse(issue([label, json, `-L 1 -q ".[0]"`]))
    case "view":
      // get an issue by id
      return JSON.parse(issue([args.number, json]))
    case "create":
      // create an issue
      return issue([assignee, label, title, body], { input: args.body })
    case "edit":
      // edit title and body of an issue
      return issue([args.number, title, body], { input: args.body })
    default:
      throw new Error(`Unknown command: ${JSON.stringify(args.command)}`)
  }
}

const getSection = (content, args) => {
  // find a section from markdown and return it with a new title
  // this uses h3 (###) to find a section
  const heading = "###"

  // remove the title since we are making a new one
  const [title, ...lines] = content
    .split(`${heading} `)
    .find(s => s.split("\n")[0].match(new RegExp(args.section, "i")))
    .trim()
    .split("\n")

  const created = `${basename(args.release)}${heading}${title}`

  return {
    title: `Release Manager: v${args.version} (${args.date})`,
    body: [
      `**Target Version**: v${args.version}`,
      `**Target Date**: ${args.date}`,
      // github markdown: 2x backticks + space will escape backticks within title
      `**Created From:** [\`\` ${created} \`\`](${args.release})`,
      ...lines,
    ]
      .join("\n")
      .trim(),
  }
}

const main = async args => {
  const replace = s => replaceAll(s, args.replacements)

  const { body, title, number } = args.create
    ? // get a section of the release process wiki doc
      getSection(await get(args.release), args)
    : // get the contents of an existing gh issue by id
      // or it will default to the most recent one by label
      // this is so it will preserve state of checked todo items
      await ghIssue({
        ...args,
        command: typeof args.update === "string" ? "view" : "list",
        number: args.update,
      })

  return ghIssue({
    ...args,
    command: number ? "edit" : "create",
    number,
    body: replace(body),
    title: replace(title),
  })
}

const parseArgs = raw => {
  const result = {
    create: false,
    update: null,
    repo: "npm/statusboard",
    label: "release-manager",
    assignee: "@me",
    date: date(),
    version: "X.Y.Z",
    replacements: {},
    section: "cli",
    release:
      "https://raw.githubusercontent.com/wiki/npm/cli/Release-Process.md",
  }

  const shorts = {
    R: "repo",
    l: "label",
    a: "assignee",
    d: "date",
    v: "version",
    c: "create",
    u: "update",
  }

  // parse argv into array of [k,v] pairs
  // works with --x=1 --x 1 --x -x
  const argv = raw
    .join(" ")
    .split(/(?:^|\s+)\-/g)
    .map(x => x.trim().replace(/\s+/g, " "))
    .filter(Boolean)
    .map(x => x.split(/[=\s]/))
    .map(([k, v]) => [
      ...(k.startsWith("-") ? ["--", k.slice(1)] : ["-", k]),
      v ?? true,
    ])
    .map(([d, k, v]) => [d, k.replace(/-([a-z])/g, a => a[1].toUpperCase()), v])

  for (const [dash, key, value] of argv) {
    const k = dash.length < 2 ? shorts[key] : key
    if (Object.hasOwn(result, k)) {
      result[k] = value
    } else {
      result.replacements[k] = value
    }
  }

  result.replacements = {
    ["(\\d+\\.\\d+\\.\\d+|X\\.Y\\.Z)"]: result.version,
    ["(\\d{4}-\\d{2}-\\d{2}|YYYY-MM-DD)"]: result.date,
    ...result.replacements,
  }

  if (!result.create && !result.update) {
    result.create = true
  } else if (result.create && result.update) {
    throw new Error("Cannot set both create and update")
  }

  if (result.help) {
    console.error(usage())
    process.exit(0)
  }

  return result
}

main(parseArgs(process.argv.slice(2)))
  .then(d => console.log(d))
  .catch(err => {
    console.error(err)
    process.exitCode = 1
  })
