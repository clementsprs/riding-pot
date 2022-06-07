class Strava::OauthRedirectsController < ApplicationController
  def complete_connection
    client = Strava::OAuth::Client.new(
      client_id: "84276",
      client_secret: "e4b52efc844481d78c6292b02b8181bf49e96586"
    )

    response = client.oauth_token(code: params[:code])

    # p response.access_token # access token
    # p response.refresh_token # refresh token
    # p response.expires_at # timestamp when the access token expires

    # response.athlete # => Strava::Models::Athlete
    current_user.access_token = response.access_token
    current_user.refresh_token = response.refresh_token
    current_user.expires_at = response.expires_at
    current_user.save

    redirect_to dashboard_path
  end
end
