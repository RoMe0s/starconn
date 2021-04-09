defmodule StarconnWeb.PostController do
    use StarconnWeb, :controller
    
    def index(conn, _params) do
        render(conn, "posts.json", posts: Starconn.Content.list_posts())
    end
end