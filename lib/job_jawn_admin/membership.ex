defmodule JJ.Membership do
  @moduledoc """
  Context responsible for managing profile information
  """

  import Ecto.Query
  alias JJ.Membership.User
  alias JJ.Repo

  def get_user(id) do
    User
    |> where([user], user.id == ^id)
    |> Repo.one()
  end
end
