defmodule ElixirCowboyExample.JavascriptHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
    {method, req} = :cowboy_req.method(req)
    {param, req} = :cowboy_req.binding(:javascript, req)
    {:ok, req} = html_example(method, param, req)
    {:ok, req, state}
  end

  def html_example("GET", :undefined, req) do
    headers = [{"content-type", "text/javascript"}]
    body = ""
    {:ok, resp} = :cowboy_req.reply(404, headers, body, req)
  end

  def html_example("GET", param, req) do
    headers = [{"content-type", "text/javascript"}]
    {:ok, file} = File.read "priv/static/js/#{param}"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
