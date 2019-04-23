defmodule Blog.Repo.Migrations.ChangePostsCategoriesIndices do
  use Ecto.Migration

  def change do
    drop unique_index(:posts_categories, [:post_id])
    drop unique_index(:posts_categories, [:category_id])

    create index(:posts_categories, [:post_id])
    create index(:posts_categories, [:category_id])
  end
end
