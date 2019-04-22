defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Repo
  alias Blog.Posts.Category

  schema "posts" do
    field :body, :string
    field :slug, :string
    field :title, :string

    many_to_many :categories, Category, join_through: "posts_categories"

    timestamps()
  end

  @doc false
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
    |> put_assoc(:categories, parse_categories(params))
    |> add_slug()
    |> unique_constraint(:slug)
  end

  defp parse_categories(params)  do
    params
    |> Map.get("categories", "")
    |> String.split(" ")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&get_or_insert_category/1)
  end

  defp get_or_insert_category(name) do
    Repo.get_by(Category, name: name) || insert_category(name)
  end

  defp insert_category(name) do
    changeset = Category.changeset(%Category{}, %{name: name})
    Repo.insert!(changeset)  
  end

  defp add_slug(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, Slugger.slugify_downcase(title))
    else
      changeset
    end
  end
end
