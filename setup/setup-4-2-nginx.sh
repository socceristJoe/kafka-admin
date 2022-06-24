#!/bin/bash

docker run -d --name joe-nginx -p 8089:80 nginx

docker exec -it joe-nginx /bin/bash
