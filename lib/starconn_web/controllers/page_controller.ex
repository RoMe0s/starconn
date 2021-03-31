defmodule StarconnWeb.PageController do
  use StarconnWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def test_insta() do
    auth_uri = URI.parse("https://api.instagram.com/oauth/authorize")
    encoded_query = URI.encode_query(%{
      client_id: "1131798467334356",
      redirect_uri: "http://localhost:4000",
      scope: "user_profile,user_media",
      response_type: "code"
    }) 

    new_auth_uri_map = auth_uri
      |> Map.from_struct()
      |> Map.put(:query, encoded_query)
      
     struct(URI, new_auth_uri_map) |> URI.to_string
  end
end
