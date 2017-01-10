defmodule ElixirCowboyExample.CssHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:css, req)
    {:ok, resp} = html_example(method, param, req)
    {:ok, resp, opts}
  end

  def html_example("GET", :undefined, req) do
    headers = %{"content-type" => "text/css"}
    body = ""
    {:ok, resp} = :cowboy_req.reply(404, headers, body, req)
  end

  def html_example("GET", param, req) do
    headers = %{"content-type" => "text/css"}
    {:ok, file} = File.read "priv/static/css/#{param}"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end
end
