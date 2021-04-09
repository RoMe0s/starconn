defmodule StarconnWeb.PostView do
    use StarconnWeb, :view
    
  def render("posts.json", %{posts: posts}) do
    %{posts: render_many(posts, StarconnWeb.PostView, "post.json", as: :post)}
  end

  def render("post.json", %{post: post}) do
    %{
      slug: post.slug,
      title: post.title,
      content: post.content,
      inserted_at: post.inserted_at
    }
  end
end