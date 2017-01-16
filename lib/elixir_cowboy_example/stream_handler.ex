defmodule ElixirCowboyExample.StreamHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do

    {:ok, req} = :cowboy_req.chunked_reply(200, req)
    :ok = :cowboy_req.chunk("<html><head>Hello world!</head>", req)
    :timer.sleep(5000)
    :ok = :cowboy_req.chunk("<body><p>Stream!</p>", req)
    :timer.sleep(5000)
    :ok = :cowboy_req.chunk("<p>Output!</p></body></html>", req)

    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
