# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :devex,
  ecto_repos: [Devex.Repo]

# Configures the endpoint
config :devex, DevexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tpJGiYv2hJwkuBD0916bfwexnEzNeVMFwO9PJT+0KNgEGVVsr7vUQ9N8GgW+y0hg",
  render_errors: [view: DevexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Devex.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
