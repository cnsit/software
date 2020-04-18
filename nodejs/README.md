## 基础

-   查看版本

```bash
node -v
```

-   更新版本

```bash
npm cache clean -f
```

## 无法更新 npm 模块的时候

-   npm config set https-proxy="http://proxy.xxx.com:80"

## Web 服务器

位于 server 文件夹下

-   `http.js` nodejs 自己的内置功能，远程 14623 Req/Sec
-   `express` 远程 7598 Req/Sec
-   `fastify` 远程 10718 Req/Sec
-   `fastifyBabel` 远程 9417 Req/Sec

## 性能测试

1. `clinic doctor -- node .\index.js`
2. `clinic flame -- node .\index.js`
3. `autocannon -c 100 -d 40 -p 10 192.168.1.2:3000`
