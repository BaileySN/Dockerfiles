## Build Container
```
docker build -t postgresql9.4 .
```
## Run Container in Deamon mode
```
docker run -p 5432:5432 --name postgresql_demoserver -d postgresql9.4
```

