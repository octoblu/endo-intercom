_ = require 'lodash'
PassportIntercom = require('passport-intercom').Strategy

class IntercomStrategy extends PassportIntercom
  constructor: (env) ->
    throw new Error('Missing required environment variable: ENDO_INTERCOM_INTERCOM_CLIENT_ID')     if _.isEmpty process.env.ENDO_INTERCOM_INTERCOM_CLIENT_ID
    throw new Error('Missing required environment variable: ENDO_INTERCOM_INTERCOM_CLIENT_SECRET') if _.isEmpty process.env.ENDO_INTERCOM_INTERCOM_CLIENT_SECRET
    throw new Error('Missing required environment variable: ENDO_INTERCOM_INTERCOM_CALLBACK_URL')  if _.isEmpty process.env.ENDO_INTERCOM_INTERCOM_CALLBACK_URL

    options = {
      clientID:     process.env.ENDO_INTERCOM_INTERCOM_CLIENT_ID
      clientSecret: process.env.ENDO_INTERCOM_INTERCOM_CLIENT_SECRET
      callbackUrl:  process.env.ENDO_INTERCOM_INTERCOM_CALLBACK_URL
    }

    super options, @onAuthorization

  onAuthorization: (accessToken, refreshToken, profile, callback) =>
    callback null, {
      id: profile.id
      username: profile.username
      secrets:
        credentials:
          secret: accessToken
          refreshToken: refreshToken
    }

module.exports = IntercomStrategy
