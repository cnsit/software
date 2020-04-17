const net = require('net')
let server = net.createServer(socket=>{
    socket.setEncoding('ascii')
    socket.end(new Date().toString())
})
server.listen(Number(process.argv[2]))