defmodule JJWeb.Auth.UserController do
  use JJWeb, :controller

  alias JJ.Auth
  alias JJ.Auth.User
  alias JJWeb.Guardian.Tokenizer.Plug, as: GuardianPlug

  def new(conn, _params) do
    render(conn, "new.html", changeset: changeset())
  end

  def create(conn, %{"user" => user_params}) do
    case Auth.authenticate_user(user_params) do
      {:ok, user} ->
        conn
        |> GuardianPlug.sign_in(user)
        |> IO.inspect()
        |> put_flash(:info, "User signed in successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, :incorrect} ->
        conn
        |> put_flash(:info, "Incorrect credentials - please try again.")
        |> render("new.html", changeset: changeset())
    end
  end

  def delete(conn, _) do
    conn
    |> GuardianPlug.sign_out()
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp changeset, do: Auth.change_user(%User{})
end
