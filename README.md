# README

Simple Rails Marketplace API

The docker setup is inspired by the following articles:
https://dev.to/hint/rails-development-with-docker-13np
https://www.freecodecamp.org/news/painless-rails-development-environment-setup-with-docker/ 


```
Build the image
docker-compose build
Run the image
docker-compose run --rm --service-ports ruby_dev
Initiate the server
rails server -p $PORT -b 0.0.0.0
```
