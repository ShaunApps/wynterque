defmodule Wynterque.Student do
  use Wynterque.Web, :model

  schema "students" do
    field :name, :string
    field :email, :string
    field :github, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :github])
    |> validate_required([:name, :email, :github])
  end
end
