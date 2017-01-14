defmodule ElixirCowboyExample.CookieHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do

     {all_cookies, req} = :cowboy_req.cookies(req)
     {cookie_val, req} = :cowboy_req.cookie("hoge", req)

     IO.inspect all_cookies
     IO.inspect cookie_val

     cookie_req = :cowboy_req.set_resp_cookie("server", "add_cookie", [
       {:max_age, 3600},
       {:domain, "localhost"},
       {:path, "/"}
       ], req)

     headers = [ {"content-type", "text/html"} ]
     body = "push cookie"
     { :ok, reply } = :cowboy_req.reply(200, headers, body, cookie_req)

     {:ok, cookie_req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
