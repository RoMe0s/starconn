defmodule Starconn.Content.Post.SyncPosts do
  use GenServer

  alias Starconn.Repo
  alias Starconn.Content.Post.Post

  @interval 60_000
  @base_url "https://starkon.city"

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def init(_args) do
    Process.send_after(self(), :poll, @interval)

    {:ok, %{last_run_at: nil, last_page: nil}}
  end

  def handle_info(:poll, state) do
    last_page = sync_posts(state.last_page)

    Process.send_after(self(), :poll, @interval)

    {:noreply, %{last_run_at: :calendar.local_time(), last_page: last_page}}
  end

  def sync_posts(prev_last_page) do
    pages_info = get_pages_info(prev_last_page)
    posts = get_posts(pages_info.pages_to_parse)

    Enum.each(Enum.chunk_every(posts, 50), fn(posts_chunk) ->
      Starconn.Repo.transaction(fn ->
        Enum.each(posts_chunk, fn(post_map) ->
          %Post{}
          |> Post.changeset(post_map)
          |> Repo.insert(returning: false,
            on_conflict: {:replace_all_except, [:id, :slug, :inserted_at]},
            conflict_target: :slug)
        end)
      end)
    end)

    pages_info.last_page
  end

  defp get_posts(pages_qty, posts \\ [])
  defp get_posts(pages_qty, posts) when pages_qty > 0 do
    loaded_posts = parse_posts_html(load_html("articles/all/" <> Integer.to_string(pages_qty)))

    IO.inspect("Pages left: " <> Integer.to_string(pages_qty - 1))

    get_posts(pages_qty - 1, posts ++ loaded_posts)
  end
  defp get_posts(pages_qty, posts) when pages_qty == 0 do
    posts
  end

  defp get_pages_info(prev_last_page) do
    {:ok, document} = Floki.parse_document(load_html("articles"))

    last_page = parse_last_page(document)

    %{last_page: last_page, pages_to_parse: get_pages_to_parse(last_page, prev_last_page)}
  end

  defp get_pages_to_parse(last_page, prev_last_page) when is_nil(prev_last_page) do
    last_page
  end
  defp get_pages_to_parse(last_page, prev_last_page) when is_integer(prev_last_page) and last_page > prev_last_page do
    last_page - prev_last_page
  end
  defp get_pages_to_parse(_last_page, prev_last_page) when is_integer(prev_last_page) do
    1
  end

  defp parse_last_page(main_page_document) do
    last_page_element = Floki.find(main_page_document, ".list-pagination [data-page]:last-child")

    if last_page_element == nil do
      1
    else
      [last_page_value] = Floki.attribute(last_page_element, "data-page")
      String.to_integer(last_page_value)
    end
  end

  defp parse_posts_html(html) when is_binary(html) do
    {:ok, document} = Floki.parse_document(html)

    document
    |> Floki.find("div.mc-block a.title")
    |> map_posts()
  end
  defp parse_posts_html(_html) do
    # error occured, html not loaded
    []
  end

  defp map_posts(posts, posts \\ [])
  defp map_posts([title | tail], posts) do
    [path] = Floki.attribute(title, "href")

    title_text = title
    |> Floki.text()
    |> String.trim()

    post = map_post(title_text, path)

    if is_nil(post) do
      map_posts(tail, posts)
    else
      map_posts(tail, posts ++ [post])
    end
  end
  defp map_posts([], posts) do
    posts
  end

  defp map_post(title, path) do
    post = parse_post_html(title, load_html(path))

    if is_nil(post) do
      nil
    else
      Map.put(post, :slug, path)
    end
  end

  defp parse_post_html(title, html) when is_binary(html) do
    {:ok, document} = Floki.parse_document(html)
    
    content = document
    |> Floki.find("div.article-text")
    |> Floki.text

    %{title: title, content: content}
  end
  defp parse_post_html(_title, _html) do
    # error occured, html not loaded
    nil
  end

  defp load_html(path) do
    HTTPoison.start()

    case HTTPoison.get(@base_url <> "/" <> String.trim_leading(path, "/")) do
      {:ok, %HTTPoison.Response{status_code: 301, headers: headers}} ->
        case Enum.find(headers, fn({name, _value}) -> name == "Location" end) do
          {"Location", redirect_path} ->
            load_html(redirect_path)
          _ ->
          nil
        end
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      _ ->
        nil
    end
  end
end