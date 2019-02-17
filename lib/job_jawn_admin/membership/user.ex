defmodule JJ.Membership.User do
  @moduledoc """
  Represents an authenticated user
  """

  use Ecto.Schema

  schema "users" do
    field(:username, :string)

    timestamps()
  end
end
