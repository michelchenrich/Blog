require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] 
require_relative './session'

class Main < Sinatra::Application
  set sessions: true

  before do
    @session = Session.new self
  end

  get '/' do
    erb :index
  end

  get '/login' do
    @session.log_in
  end
end
