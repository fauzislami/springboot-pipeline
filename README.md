Welcome to testing app!!

# Spring Boot Actuator Hello-world
Simple Spring Boot Actuator REST-full service

Based on the tutorial [Building a RESTfull Web Service with Spring Boot Actuator](https://spring.io/guides/gs/actuator-service/), it will be use a sample Java application on different places where it is needed.
All the Actuator end-points are enable. For more information about Spring Boot Actuator click [here](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html)

# Compiling, unit test and package

```
$ mvn clean compile test package
```

# Running
```
$ java -jar target/gs-actuator-service-0.1.0.jar
```

# Testing connectivity

## /hello-world
```
$ curl localhost:9000/hello-world | python -m json.tool
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100    37    0    37    0     0   3301      0 --:--:-- --:--:-- --:--:--  4111
  {
      "id": 1,
      "content": "Hello, Stranger!"
  }
```

## Not Found
```
$ curl localhost:9000/abcd | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   125    0   125    0     0  16497      0 --:--:-- --:--:-- --:--:-- 31250
{
    "timestamp": "2000-01-01T01:01:01.0001+0000",
    "status": 404,
    "error": "Not Found",
    "message": "No message available",
    "path": "/abcd"
}
```

## /actuator/health
```
$ curl localhost:9001/actuator/health | python -m json.tool
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                   Dload  Upload   Total   Spent    Left  Speed
  100    15    0    15    0     0   2393      0 --:--:-- --:--:-- --:--:--  5000
  {
      "status": "UP"
  }
```


