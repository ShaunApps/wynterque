# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wynterque,
  ecto_repos: [Wynterque.Repo]

# Configures the endpoint
config :wynterque, Wynterque.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nE7zkt0WFHKZnrZhlcOx/XS9k+wpJcHlTdZYhQLFDyqgKnuYiHuzv9WNdh7KP8p6",
  render_errors: [view: Wynterque.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wynterque.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :ueberauth, Ueberauth,
  providers: [cas: {Ueberauth.Strategy.CAS, [
    base_url: "http://login.wyncode.co",
    callback: "http://localhost:4000",
  ]}]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
