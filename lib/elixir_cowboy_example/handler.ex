defmodule ElixirCowboyExample.Handler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
    {method, req} = :cowboy_req.method(req)
    {param, req} = :cowboy_req.binding(:html, req)
    {:ok, req} = html_example(method, param, req)
    {:ok, req, state}
  end

  def html_example("GET", :undefined, req) do
    headers = [{"content-type", "text/html"}]
    body = """
      <html>
        <head>
          <meta charset=\"utf-8\">
        	<title>Cowboy Hello!</title>
        </head>
        <body>
          <h1>Cowboy Hello!!</h1>
        </body>
      </html>
    """
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def html_example("GET", param, req) do
    headers = [{"content-type", "text/html"}]
    {:ok, file} = File.read "priv/static/html/index.html"
    body = file
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
