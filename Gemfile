source 'https://rubygems.org'

gem "bundler"
gem 'rack'
gem "latex_to_png", '0.0.4'
gem "redis"
# gem "latex_to_png", :path => "../latex_to_png/"
gem 'newrelic_rpm'

group :test,:development do
  gem 'byebug'
	gem "rspec"
end

group :development do
  #https://github.com/capistrano/capistrano/blob/master/README.md
	gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'

end
