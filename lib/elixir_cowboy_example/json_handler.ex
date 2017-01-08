defmodule ElixirCowboyExample.JsonHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    {ok, params, req} = :cowboy_req.read_urlencoded_body(req)
    {:ok, resp} = json_example(method, params, req)
    {:ok, resp, opts}
  end

  def json_example("POST", :undefined, req) do
    headers = %{"content-type" => "application/json"}
    body = "{\"title\": \"hello cowboy!\"}"
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def json_example("POST", params, req) do
    param = params |> Enum.at(0) |> elem(1)
    headers = %{"content-type" => "application/json"}
    body = "{\"title\": \"#{param}\"}"
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end
end
