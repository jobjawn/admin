defmodule JJ.Signup.User do
  @moduledoc """
  Currently represents admin users of the system.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> put_pass_hash()
  end

  defp put_pass_hash(%{valid?: true, changes: params} = changeset) do
    password = Bcrypt.hash_pwd_salt(params[:password])
    change(changeset, password: password)
  end

  defp put_pass_hash(changeset) do
    change(changeset, password: "")
  end
end
