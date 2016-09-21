defmodule Wynterque.Repo.Migrations.AddExIdToStudent do
  use Ecto.Migration

  def change do
    alter_table(:students) do
      add :ex_id, :string
    end

    creat unique_index(:students, [:ex_id])
  end
end
