const http = require('http')
const server = http.createServer((req,res)=>{
    res.writeHead(200,{'Content-Type':'text/plain'})
    res.end(new Date().toString())
})
server.listen(Number(process.argv[2]))