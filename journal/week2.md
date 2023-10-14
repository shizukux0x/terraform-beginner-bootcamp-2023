# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems).


#### Install Gems

Define gems in a Gemfile.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then run the `bunble install` command. This will install the gems on the system globally.

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This the way we set context.

#### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec rudy server.rb
```

All of the code for the server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD

CRUD stands for Create, Read, Update, Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete