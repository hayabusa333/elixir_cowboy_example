# ElixirCowboyExample
- used
``` cmd
$ mix deps.get
$ iex -S mix  
```
- html

```cmd
$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d 'title=test1' http://localhost:4000/json
*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 4000 (#0)
> POST /json HTTP/1.1
> Host: localhost:4000
> User-Agent: curl/7.43.0
> Accept: application/json
> Content-type: application/json
> Content-Length: 23
> 
* upload completely sent off: 23 out of 23 bytes
< HTTP/1.1 200 OK
< server: Cowboy
< date: Sat, 07 Jan 2017 06:16:54 GMT
< content-length: 18
< content-type: application/json
< 
* Connection #0 to host localhost left intact
{"title": "test1"}
```


