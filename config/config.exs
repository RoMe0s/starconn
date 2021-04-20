# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :starconn,
  ecto_repos: [Starconn.Repo]

# Configures the endpoint
config :starconn, StarconnWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6eY8VD91qsReDLv94bZG654CzmqMiRMZ1SB+eBpqdsIWzqVm8LEn7QgluXEWWVa+",
  render_errors: [view: StarconnWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Starconn.PubSub,
  live_view: [signing_salt: "jydlxK9J"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :nadia,
  token: "1764304085:AAFztXs6IHdylYSe2RU9-zXwjbOJfT3Be-E"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
