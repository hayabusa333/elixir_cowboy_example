defmodule ElixirCowboyExample.JsonHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
    {method, req} = :cowboy_req.method(req)
    {:ok, params, req} = :cowboy_req.body_qs(req)
    IO.inspect params
    {:ok, req} = json_example(method, params, req)
    {:ok, req, state}
  end

  def json_example("POST", :undefined , req) do
    headers = [{"content-type", "application/json"}]
    body = "{\"title\": \"hello cowboy!\"}"
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def json_example("POST", params, req) do
    param = params |> Enum.at(0) |> elem(1)
    headers = [{"content-type", "application/json"}]
    IO.puts "3"
    body = "{\"title\": \"#{param}\"}"
    IO.puts "4"
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
