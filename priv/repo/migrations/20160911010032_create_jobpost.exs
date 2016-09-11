defmodule Wynterque.Repo.Migrations.CreateJobpost do
  use Ecto.Migration

  def change do
    create table(:jobposts) do
      add :" title", :string
      add :description, :text
      add :organization, :string
      add :email, :text
      add :location, :string
      add :url, :string
      add :contact, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:jobposts, [:user_id])

  end
end
