defmodule ElixirCowboyExample.SendFileHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do

     path = "priv/static/image/button.png"

     %File.Stat{size: file_size} = File.stat!(path)

     body_fun = fn(socket, transport) -> 
                  transport.sendfile(socket, path)
                end

     headers = [ {"content-type", "image/png"} ]

     {:ok, req} = :cowboy_req.reply(200, headers, :cowboy_req.set_resp_body_fun(file_size, body_fun, req))

     {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
