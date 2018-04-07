docker build . -t py-alpine-robot-ta && \ 
docker run --env-file ./setenv/sit1.env -it py-alpine-robot-ta