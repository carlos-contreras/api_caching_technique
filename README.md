# api_caching_technique
This is a prof of concept for caching API calls using a Redis List, now once the API responses (or rather the records) are cached in Redis, we can implement filtering and pagination in our own side against the cached data, this will improve performance overall in a real life production application that pulls data from a third party for them displaying it on a more dynamic way

# Running the project

Just install the dependencies

```bash
gem install redis
gem install faker
```

then run the `main` file

```bash
ruby main.rb
```
