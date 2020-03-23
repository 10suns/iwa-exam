# README

Fetch and display the the list from https://news.ycombinator.com/best

* Ruby version

  - Ruby 2.6.1

* System dependencies

  - NodeJS 3.11.x
  - Bower 1.8.8

### Configuration

Run

```
# install gems
$ bundle install --path vendor/bundle 
# install js libraries
$ bundle exec rake bower:install
```

### How to run the test suite

```
$bundle exec rspec
```

### Deployment instructions

Heroku

- following [here](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app) to config multi buildpack(nodejs should load before ruby)
- following [here](https://devcenter.heroku.com/articles/getting-started-with-rails5) to deploy app to heroku
