chalk = require 'chalk'
emoji = require 'node-emoji'
open = require 'opn'

report = () ->
  console.log ''
  console.log chalk.cyan " #{emoji.get 'love_letter'} thank you for contribution!"
  open('https://github.com/just-fine/fine.sh-cli/issues/new')
  process.exit 1

module.exports =
  run: report
