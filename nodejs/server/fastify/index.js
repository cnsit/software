const f = require('fastify')({
	logger:false
})
f.get('/',(req,res)=>{
	res.send('Hello World! Fastify')
})
f.listen(3000,(err,addr)=>{
	if(err)throw err
	f.log.info(`server listen on ${addr}`)
})
