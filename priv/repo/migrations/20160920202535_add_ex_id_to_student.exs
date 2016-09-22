defmodule Wynterque.Repo.Migrations.AddExIdToStudent do
  use Ecto.Migration

  def change do
    alter table(:students) do
      add :ex_id, :string
    end

    create unique_index(:students, [:ex_id])
  end
end
