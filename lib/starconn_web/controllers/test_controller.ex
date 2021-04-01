defmodule StarconnWeb.TestController do
  use StarconnWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end