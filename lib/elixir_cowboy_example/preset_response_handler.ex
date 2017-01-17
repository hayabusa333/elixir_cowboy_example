defmodule ElixirCowboyExample.PresetResponseHandler do
  def init(req, opts) do

    IO.inspect req

    req = :cowboy_req.set_resp_header("allow", "GET", req)
    IO.puts "----------------"
    IO.inspect req

    req = :cowboy_req.set_resp_body("Hello world!", req)
    IO.puts "----------------"
    IO.inspect req

    :cowboy_req.reply(200, req)

    {:ok, req, opts}
  end

end
