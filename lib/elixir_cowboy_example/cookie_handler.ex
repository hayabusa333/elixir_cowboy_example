defmodule ElixirCowboyExample.CookieHandler do
  def init(req, opts) do
    cookie_req = :cowboy_req.set_resp_cookie("server", "add_cookie", 
       %{max_age: 3600, domain: "localhost", path: "/"},
       req)

    header = %{"content-type" => "text/html"}
    body = "push cookie"
    { :ok, reply } = :cowboy_req.reply(200, header, body, cookie_req)

    {:ok, cookie_req, opts}
  end
end
