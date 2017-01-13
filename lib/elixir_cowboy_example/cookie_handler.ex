defmodule ElixirCowboyExample.CookieHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
     cookie_req = :cowboy_req.set_resp_cookie("server", "add_cookie", [
       {:max_age, 3600},
       {:domain, "localhost"},
       {:path, "/"}
       ], req)

     headers = [ {"content-type", "text/html"} ]
     body = "push cookie"
     { :ok, reply } = :cowboy_req.reply(200, headers, body, cookie_req)

     {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
