defmodule ElixirCowboyExample.BrowserCheckHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do


    {user_agent_val, req} = :cowboy_req.header(<<"user-agent">>, req)

    headers = [{"content-type", "text/html"}]

    body = cond do
      String.contains?(user_agent_val, "Chrome") 
        -> "<html><head>Chrome Hello world!</head>"
      String.contains?(user_agent_val, "Safari") 
        -> "<html><head>Safari Hello world!</head>"
      true 
        -> "<html><head>Hello world!</head>"
    end

    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
