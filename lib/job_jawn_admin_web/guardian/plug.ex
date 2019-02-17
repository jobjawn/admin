defmodule JJWeb.Guardian.Plug do
  @moduledoc """
  Pipeline which ensures a user is authenticated
  """

  use Guardian.Plug.Pipeline,
    otp_app: :job_jawn_admin,
    error_handler: JJWeb.Guardian.ErrorHandler,
    module: JJWeb.Guardian.Tokenizer

  # If there is a session token, validate it
  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})

  # If there is an authorization header, validate it
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})

  # Load the user if either of the verifications worked
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
