defmodule Wynterque.Repo.Migrations.AddCategoryIdToJobpost do
  use Ecto.Migration

  def change do
    alter table(:jobposts) do
      add :category_id, references(:categories)
    end

  end
end
