require '../utils/normalize'
commander = require 'commander'
notifier = require 'update-notifier'
pkg = require '../../package.json'

notifier { pkg, updateCheckInterval: 1 }
  .notify { isGlobal: true }


commander
  .version pkg.version, '-v, --version'
  .usage '<command> [options]'
  .parse(process.argv)

build = require '../scripts/start'
