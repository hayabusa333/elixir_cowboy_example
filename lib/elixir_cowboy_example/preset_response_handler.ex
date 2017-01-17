defmodule ElixirCowboyExample.PresetResponseHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do

    IO.inspect req

    req = :cowboy_req.set_resp_header("allow", "GET", req)
    IO.puts "----------------"
    IO.inspect req

    req = :cowboy_req.set_resp_body("Hello world!", req)

#    body_fun = fn(socket, transport) ->
#      transport.send(socket, "Hello world!")
#    end
#    req = :cowboy_req.set_resp_body_fun(12, body_fun, req)

    IO.puts "----------------"
    IO.inspect req

    :cowboy_req.reply(200, req)

    


    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
