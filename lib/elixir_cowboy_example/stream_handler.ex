defmodule ElixirCowboyExample.StreamHandler do
  def init(req, opts) do

    req = :cowboy_req.stream_reply(200, req)
    
    :cowboy_req.stream_body("<html><head>Hello world!</head>", :nofin, req)
    :timer.sleep(2000)
    :cowboy_req.stream_body("<body><p>Stream!</p>", :nofin, req)
    :timer.sleep(2000)
    :cowboy_req.stream_body("<p>Output!</p></body></html>", :fin, req)

    {:ok, req, opts}
  end

end
