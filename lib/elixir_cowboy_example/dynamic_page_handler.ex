defmodule ElixirCowboyExample.DynamicPageHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
    {method, req} = :cowboy_req.method(req)
    {param, req} = :cowboy_req.binding(:html, req)
    {:ok, req} = html_example(method, req)
    {:ok, req, state}
  end

  def html_example(method, req) do
    {url, req} = :cowboy_req.url(req)
    {version, req} = :cowboy_req.version(req)
    headers = [{"content-type", "text/html"}]
    body = """
      <html>
        <head>
          <meta charset=\"utf-8\">
        	<title>Cowboy Hello!</title>
        </head>
        <body>
          <h1>Cowboy Hello!!</h1>
          <h2>url = #{url}</h2>
          <h2>method = #{method}</h2>
          <h2>version = #{version}</h2>
        </body>
      </html>
    """
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
