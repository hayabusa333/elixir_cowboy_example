defmodule ElixirCowboyExample.BrowserCheckHandler do
  def init(req, opts) do

    user_agent_val = :cowboy_req.header(<<"user-agent">>, req)

    headers = %{"content-type" => "text/html"}

    body = cond do
      String.contains?(user_agent_val, "Chrome") 
        -> "<html><head>Chrome Hello world!</head>"
      String.contains?(user_agent_val, "Safari") 
        -> "<html><head>Safari Hello world!</head>"
      true 
        -> "<html><head>Hello world!</head>"
    end

    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)

    {:ok, req, opts}
  end
end
