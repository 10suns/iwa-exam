# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'nokogiri'

gem 'ruby-readability', require: 'readability'

# Use Slim template for views.
gem 'slim', require: 'slim-rails'
gem 'slim-rails'

# On MacOS, to install bower client run
# $ brew install node
# $ npm install -g bower
gem 'bower-rails'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # pry
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-power_assert'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  # rspec
  gem 'rspec-rails'

  gem 'rubocop', require: false
end
