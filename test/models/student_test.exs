defmodule Wynterque.StudentTest do
  use Wynterque.ModelCase

  alias Wynterque.Student

  @valid_attrs %{email: "some content", github: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
