defmodule Wynterque.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :email, :string
      add :github, :string

      timestamps()
    end

  end
end
