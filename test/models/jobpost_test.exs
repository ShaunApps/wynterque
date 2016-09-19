defmodule Wynterque.JobpostTest do
  use Wynterque.ModelCase

  alias Wynterque.Jobpost

  @valid_attrs %{title: "some content", contact: "some content", description: "some content", email: "some content", location: "some content", organization: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Jobpost.changeset(%Jobpost{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Jobpost.changeset(%Jobpost{}, @invalid_attrs)
    refute changeset.valid?
  end
end
