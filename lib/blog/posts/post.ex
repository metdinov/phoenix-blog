defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Posts.Category

  schema "posts" do
    field :body, :string
    field :slug, :string
    field :title, :string

    many_to_many :categories, Category, join_through: "posts_categories"

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :slug])
    |> validate_required([:title, :body])
    |> add_slug()
    |> unique_constraint(:slug)
  end

  defp add_slug(changeset) do
    title = get_change(changeset, :title)
    put_change(changeset, :slug, Slugger.slugify_downcase(title))
  end
end
