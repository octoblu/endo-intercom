http           = require 'http'
IntercomClient = require 'intercom-client'

class ListConversations
  constructor: ({@encrypted}) ->
    @client = new Intercom.Client token: @encrypted.secrets.credentials.secret

  do: ({data}, callback) =>
    @client.conversations.list {}, (error, result) =>
      return callback error if error?
      return callback null, {
        metadata:
          code: 200
          status: http.STATUS_CODES[200]
        data: result
      }

module.exports = ListConversations
