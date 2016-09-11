defmodule Wynterque.Jobpost do
  use Wynterque.Web, :model

  schema "jobposts" do
    field :title, :string
    field :description, :string
    field :organization, :string
    field :email, :string
    field :location, :string
    field :url, :string
    field :contact, :string
    belongs_to :user, Wynterque.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description, :organization, :email, :location, :url, :contact])
    |> validate_required([:title, :description, :organization, :email, :location, :url, :contact])
  end
end
