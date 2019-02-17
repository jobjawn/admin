defmodule JJ.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias JJ.Auth.User
  alias JJ.Repo

  @doc """
  Finds a User record by username - if the given password matches a found user
  returns a success tuple with the user.  If no user is found or if the password
  does not match returns an error tuple.

  ## Examples

      iex> authenticate_user(%{"username" => user, "password" => pass})
      {:ok, %User{}}

      iex> authenticate_user(%{"username" => not_user, "password" => pass})
      {:error, :incorrect}

      iex> authenticate_user(%{"username" => user, "password" => not_pass})
      {:error, :incorrect}
  """
  def authenticate_user(%{"username" => user, "password" => pass}) do
    user
    |> fetch_user_by_username()
    |> check_password(pass)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  defp check_password(%User{} = user, password) do
    password
    |> Bcrypt.verify_pass(user.password)
    |> case do
      true ->
        {:ok, user}
      false ->
        check_password(nil, nil)
    end
  end

  defp check_password(_, _) do
    Bcrypt.no_user_verify()

    {:error, :incorrect}
  end

  defp fetch_user_by_username(username) do
    User
    |> where([user], user.username == ^username)
    |> Repo.one
  end
end
