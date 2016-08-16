require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] 

class Main < Sinatra::Application
  get '/' do
    'This is going to be a nice little blog'
  end
end
