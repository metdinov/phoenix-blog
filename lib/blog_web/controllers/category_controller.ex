defmodule BlogWeb.CategoryController do
  use BlogWeb, :controller

  alias Blog.Posts
  alias Blog.Posts.Category

  def index(conn, _params) do
    categories = Posts.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def show(conn, %{"id" => id}) do
    category = Posts.get_category!(id)
    posts = Posts.get_category_posts!(id)
    render(conn, "show.html", category: category, posts: posts)
  end
end
