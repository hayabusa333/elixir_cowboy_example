defmodule ElixirCowboyExample.UploadHandler do
  def init({:tcp, :http}, req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
     {:ok, headers, req} = :cowboy_req.part(req)
     {:file, "inputfile", filename, content_type, _te} 
       = :cow_multipart.form_data(headers)
     {:ok, binary, req} = :cowboy_req.body(req)
     {:ok, file} = File.open("priv/static/upload/#{filename}", [:write])
     IO.binwrite(file, binary)
     File.close(file)

     head = [ {"content-type", "text/html"} ]
     body = "file upload ok"
     { :ok, reply } = :cowboy_req.reply(200, head, body, req)

     {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
