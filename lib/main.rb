require 'bundler'
Bundler.require :default, ENV['RACK_ENV']
require_relative './session'
require 'rouge/plugins/redcarpet'

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

class Main < Sinatra::Application
  set sessions: true

  helpers do
    def session_status
      @session.exists? ? 'Admin' : 'Guest'
    end
  end

  before do
    @session = Session.new self
  end

  get '/' do
    content_request = RestClient.get "#{ENV['CONTENT_URL']}/first_post"
    erb :index, locals: {user: session_status, css: Rouge::Themes::Github.render} do
      Redcarpet::Markdown.new(HTML, {
        autolink: true,
        tables: true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: true,
        underline: true,
        line_numbers: true
      }).render(content_request.to_str)
    end
  end

  get '/login' do
    @session.log_in
    redirect '/'
  end

  get '/logout' do
    @session.log_out
    redirect '/'
  end
end
