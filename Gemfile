source 'https://rubygems.org'

ruby "2.1.1"

gem 'rails', '4.0.4'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'paperclip'
gem 'figaro'
gem 'bcrypt-ruby', '~> 3.1.2'

group :production do
	gem 'rails_12factor'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'rspec'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'debugger'
end
