# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :job_jawn_admin,
  namespace: JJ,
  ecto_repos: [JJ.Repo]

# Configures the endpoint
config :job_jawn_admin, JJWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IO+N+sdMTJS/CW1KpxMinkEUqOmxcbFYmmcF8cSNXFhC1nng0VA9fiY1wZxlb9YO",
  render_errors: [view: JJWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: JJ.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
