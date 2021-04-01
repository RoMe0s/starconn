defmodule StarconnWeb.TestView do
  use StarconnWeb, :view

  def render("index.json", _params) do
    %{lol: "hehey"}
  end
end

