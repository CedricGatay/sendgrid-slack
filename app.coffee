require "coffee-script/register"

express = require("express")
logger = require("morgan")
bodyParser = require("body-parser")
app = express()

app.use logger("dev")
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: true)

if process.env.SLACK_URL == undefined
  throw "SLACK_URL must be defined"

Slack = require('node-slack')
slack = new Slack(process.env.SLACK_URL)

app.post '/', (req, res) ->
  if process.env.DEBUG
    console.log(req.body)

  for event in req.body
    slack.send
      text: event.event + " event for: " + event.email,
      channel: process.env.SLACK_CHANNEL || 'general'
      icon_emoji: ':email:',
      username: 'sendgrid'
  res.status 200
  res.send ''

module.exports = app

port = 3000
app.listen(process.env.PORT || port)

console.log('Express started on port ' + port)
