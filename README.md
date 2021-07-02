# README

## App Schema

Model : task

| Column      |  Description   |
| ----------- | -------------- |
| Task_name   | String         |
| Description | String         |
| Status      | String         |
| Priority    | String         |
| Deadline    | Date           |

### How to deploy on Heroku

#### Creation of the app on heroku
```
$ heroku login
$ heroku create everyleaf-assignment
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
#### Compile the app and push it on heroku
```
$ rails assets:precompile RAILS_ENV=production
$ git add -A
$ git commit -m "message"
$ git push heroku master
```
#### Migration and open app link
```
$ heroku run:detached rails db:migrate
$ heroku open app
```
##### List of gems required
```
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'rexml'
```
