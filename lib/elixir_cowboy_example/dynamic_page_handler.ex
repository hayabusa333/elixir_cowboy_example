defmodule ElixirCowboyExample.DynamicPageHandler do
  def init(req, opts) do
    method = :cowboy_req.method(req)
    param = :cowboy_req.binding(:html, req)
    {:ok, resp} = html_example(method, req)
    {:ok, resp, opts}
  end

  def html_example(method, req) do
    headers = %{"content-type" => "text/html"}
    IO.inspect :cowboy_req.uri(req)
    version = :cowboy_req.version(req)
    body = """
      <html>
        <head>
          <meta charset=\"utf-8\">
                <title>Cowboy Hello!</title>
        </head>
        <body>
          <h1>Cowboy Hello!!</h1>
          <h2>url = #{:cowboy_req.scheme(req)}//#{:cowboy_req.host(req)}:#{:cowboy_req.port(req)}#{:cowboy_req.path(req)}#{:cowboy_req.qs(req)}</h2>
          <h2>method = #{method}</h2>
          <h2>version = #{version}</h2>
        </body>
      </html>
    """
    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
  end
end
