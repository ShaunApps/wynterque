defmodule Wynterque.Repo.Migrations.ChangeWeirdTitle do
  use Ecto.Migration

  def change do
    alter table(:jobposts) do
      remove :" title"
      add :title, :string
    end
  end
end
