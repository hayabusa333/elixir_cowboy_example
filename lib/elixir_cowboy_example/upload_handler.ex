defmodule ElixirCowboyExample.UploadHandler do
  def init(req, opts) do
    {:ok, headers, req} = :cowboy_req.read_part(req)
    {:ok, binary, req} = :cowboy_req.read_part_body(req)
    {:file, "inputfile", filename, content_type, _te}
      = :cow_multipart.form_data(headers)
    {:ok, file} = File.open("priv/static/upload/#{filename}", [:write])
    IO.binwrite(file, binary)
    File.close(file)

    head = %{"content-type" => "text/html"}
    body = "file upload ok"
    { :ok, reply } = :cowboy_req.reply(200, head, body, req)

    {:ok, req, opts}
  end
end
