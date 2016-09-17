defmodule  Wynterque.TestHelpers do
  alias Wynterque.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
      password: "supersecret",
      }, attrs)

      %Wynterque.User{}
      |> Wynterque.User.registration_changeset(changes)
      |> Repo.insert!()
  end

  def insert_jobpost(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:jobposts, attrs)
    |> Repo.insert!()
  end

end
