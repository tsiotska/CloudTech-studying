## LINUX NGINX MONGO NODE stack 

<details>
<summary>Nginx configuration</summary>

```nginx/sites-available/default```

Here i have two locations: '/' to service static
and '/api/' to service dynamic content in accordance 

'/api/' is proxying to 3000 port of localhost, there i'm gonna run backend application

It doesn't have any CORS configured yet

![](screenshots/nginx_config.png)

![](screenshots/html.png)

![](screenshots/nginx_res.png)

</details>
<br/>

<details>
<summary>Node express init</summary>

I should install http-server, that is Express.js, 
so my backend application could handle http requests

Make sure there're node.js installed in system

![](screenshots/express/versions_check.png)

I used express generator package from npm:

https://www.npmjs.com/package/express-generator

![](screenshots/express/express_init.png)

Added response to '/' route

![](screenshots/express/express_testroute.png)

Verification whether it runs

![](screenshots/express/express_start.png)

![](screenshots/express/mv_express.png)

Accessed localhost/api, after restarting both nginx and node 

![](screenshots/express/api_res.png)

</details>
<br/>

<details>
<summary>MongoDB installation</summary>

First thing first i should replace systemctl utility, so it works without systemd

https://github.com/gdraheim/docker-systemctl-replacement

![](screenshots/mongo/systemctl_substitute.png)

![](screenshots/mongo/systemctl_python.png)

I chose to install Mongo 5.0:

![](screenshots/mongo/mongo_installation.png)

![](screenshots/mongo/mongod_start.png)

Launched: 

![](screenshots/mongo/Finally_db_connected.png)

![](screenshots/mongo/mongod_process.png)
</details>
