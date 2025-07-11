Решение "Simple Docker"

- [Part 1. Готовый докер](#part-1-готовый-докер)
- [Part 2. Операции с контейнером](#part-2-операции-с-контейнером)
  
## Part 1. Готовый докер

- `docker pull`

<div>
<img src="screenshots/1.Docker_pull_nginx.png" alt="Pull image" width="500"/>
</div>

- `docker images`

<div>
<img src="screenshots/2.Docker_image_nginx.png" alt="Images_List" width="500"/>
</div>

- `docker run -d [repository]`
 
<div>
<img src="screenshots/3.Docker_run_image_nginx.png" alt="Run_image" width="500"/>
</div>

- `docker ps`
 
<div>
<img src="screenshots/4.Docker_ps.png" alt="Work_process" width="500"/>
</div>

- `docker inspect [container_name]`

<div><img src="screenshots/5.1.Container_inspect.png" alt="container_inspect_name" width="500"/>
</div>

<div>
<img src="screenshots/5.2.Container_size.png" alt="Size" width="500"/>
</div>

<div>
<img src="screenshots/5.3.Container_nomap_ports.png" alt="Ports" width="500"/>
</div>
Проброса портов внутрь контейнера нет, а только информация, что контейнер слушает на порту 80. Проброс достигается запуском контейнера с ключом -p и указанием номеров портов для проброса, например: 

`-p 8080:80`

<div>
<img src="screenshots/5.4.Container_IP.png" alt="IP" width="500"/>
</div>

- `docker stop [container_id]`

<div>
<img src="screenshots/6.Container_stop.png" alt="min_max_hosts4" width="500"/>
</div>

- `docker run -d -p 80:80 -p 443:443 [container_id]`

<div>
<img src="screenshots/7.Container_sarts_with_mapping.png" alt="localhost" width="500"/>
</div>  

- Запуск браузера по адресу `localhost:80`

<div>
<img src="screenshots/8.Site_NGINX.png" alt="ip_gw" width="500"/>
</div>  

- `docker restart [container_name]`

<div>
<img src="screenshots/9.Restart.png" alt="ws1" width="500"/>
</div> 

<div>
<img src="screenshots/8.Site_NGINX.png" alt="ws2" width="500"/>
</div> 

## Part 2. Операции с контейнером

- `docker exec nginx cat /etc/nginx/nginx.conf` 
  
<div>
<img src="screenshots/10.Exec.png" alt="exec" width="500"/>
</div> 

- `nano src/nginx.conf` 
<div>
<img src="screenshots/11.Conf_with_status.png" alt="status" width="500"/>
</div> 

- `docker cp src/nginx.conf dreamy_dijkstra:/etc/nginx/nginx.conf` 
 
<div>
<img src="screenshots/12.Copy_conf.png" alt="copy" width="500"/>
</div>  

- `docker exec dreamy_dijkstra nginx -s reload`

<div>
<img src="screenshots/13.Start_conf.png" alt="restart" width="500"/>
</div>  

- `localhost:80/status`  

<div>
<img src="screenshots/14.Status_inf.png" alt="status_infs1" width="500"/>
</div> 

- `docker export [CONTAINER ID] -o src/container.tar`  

<div>
<img src="screenshots/15.Container.png" alt="arc_to-container" width="500"/>
</div> 


- `docker stop [CONTAINER ID]`

<div>
<img src="screenshots/16.Stop_Container.png" alt="stop" width="500"/>
</div> 

- `docker rm [CONTAINER ID]`

<div>
<img src="screenshots/17.Delete_Container.png" alt="delete" width="500"/>
</div> 

- `docker rmi [repository]`

<div>
<img src="screenshots/18.Delete_Image.png" alt="delete_img" width="500"/>
</div> 

- `docker import src/container.tar mynginx:imported`

<div>
<img src="screenshots/19.Import.png" alt="import" width="500"/>
</div> 

- `docker run -d --name MyNginx -p 80:80 mynginx:imported nginx -g 'daemon off;'`  

<div>
<img src="screenshots/20.Run_after_import.png" alt="run" width="500"/>
</div> 

- `curl http://localhost/status`  

<div>
<img src="screenshots/21.Curl_Status_inf.png" alt="status" width="500"/>
</div> 

****

Part 3. Мини веб-сервер

- мини-сервер на **C** и **FastCgi**, который будет возвращать простейшую страничку с надписью `Hello, World!`.

<div>
<img src="screenshots/22.MiniServer_C.png" alt="web-server" width="500"/>
</div> 

- *nginx.conf*, который будет проксировать все запросы с 81 порта на *127.0.0.1:8080*.
  
<div>
<img src="screenshots/23.Nginx_conf.png " alt="iptables_ws2" width="500"/>
</div> 
