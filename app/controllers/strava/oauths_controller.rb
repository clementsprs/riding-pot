class Strava::OauthsController < ApplicationController
  def connect
    client = Strava::OAuth::Client.new(
      client_id: "84276",
      client_secret: "e4b52efc844481d78c6292b02b8181bf49e96586"
    )

    redirect_url = client.authorize_url(
      redirect_uri: complete_connection_strava_oauth_redirect_url,
      approval_prompt: 'force',
      response_type: 'code',
      scope: 'activity:read_all',
      state: 'magic'
    )

    redirect_to redirect_url
  end
end
