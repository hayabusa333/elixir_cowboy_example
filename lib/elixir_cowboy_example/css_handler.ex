defmodule ElixirCowboyExample.CssHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
    {method, req} = :cowboy_req.method(req)
    {param, req} = :cowboy_req.binding(:css, req)
    {:ok, req} = html_example(method, param, req)
    {:ok, req, state}
  end

  def html_example("GET", :undefined, req) do
    headers = [{"content-type", "text/css"}]
    body = ""
    {:ok, resp} = :cowboy_req.reply(404, headers, body, req)
  end

  def html_example("GET", param, req) do
    headers = [{"content-type", "text/css"}]
    {:ok, file} = File.read "priv/static/css/#{param}"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
