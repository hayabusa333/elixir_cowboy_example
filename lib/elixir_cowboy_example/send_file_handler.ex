defmodule ElixirCowboyExample.SendFileHandler do
  def init(req, opts) do

    path = "priv/static/image/button.png"

    %File.Stat{size: file_size} = File.stat!(path)

    header = %{"content-type" => "image/png"}

    req = :cowboy_req.reply(200, header , 
            {:sendfile, 0, file_size, path}, req)

    {:ok, req, opts}
  end
end
