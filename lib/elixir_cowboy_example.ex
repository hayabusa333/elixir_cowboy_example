defmodule ElixirCowboyExample do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: ElixirCowboyExample.Worker.start_link(arg1, arg2, arg3)
      # worker(ElixirCowboyExample.Worker, [arg1, arg2, arg3]),
      worker(__MODULE__, [], function: :run)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirCowboyExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run do
    routes = [
      {"/", ElixirCowboyExample.Handler, []},
      {"/cookie", ElixirCowboyExample.CookieHandler, []},
      {"/upload", ElixirCowboyExample.UploadHandler, []},
      {"/dynamic", ElixirCowboyExample.DynamicPageHandler, []},
      {"/json", ElixirCowboyExample.JsonHandler, []},
      {"/:html", ElixirCowboyExample.Handler, []},
      {"/priv/static/js/:javascript", ElixirCowboyExample.JavascriptHandler, []},
      {"/priv/static/css/:css", ElixirCowboyExample.CssHandler, []},
      {"/priv/static/image/[...]", :cowboy_static, {:priv_dir, :elixir_cowboy_example, "static/image"}}
    ]

    dispatch = :cowboy_router.compile([{:_, routes}])

    opts = [{:port, 4000}]
    env = %{dispatch: dispatch}

    {:ok, _pid} = :cowboy.start_clear(:http, 100, opts, %{env: env})
  end
end
