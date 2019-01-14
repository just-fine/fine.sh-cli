require '../utils/normalize'
commander = require 'commander'
notifier = require 'update-notifier'
pkg = require '../../package.json'

notifier { pkg, updateCheckInterval: 1 }
  .notify { isGlobal: true }

commander.on '--help', ->
  console.log ''
  console.log 'Commands:'
  console.log '  login  --  login'
  console.log '  ls  --  show all projects'
  console.log '  rm  --  remove a project'
  console.log '  who  --  show current user'

commander
  .version pkg.version, '-v, --version'
  .parse(process.argv)

build = require '../scripts/start'
