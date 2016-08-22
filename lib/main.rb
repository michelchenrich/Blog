require_relative './libraries'
require_relative './session'
require_relative './content'
require_relative './renderer'
require_relative './reporter'
require_relative './report'
require_relative './presenter'

class Main < Sinatra::Application
  set sessions: true

  before do
    @session = Session.new self
    @content = Content.new Renderer.new
    @reporter = Reporter.new Report.new
    @presenter = Presenter.new self, @content
  end

  get '/' do
    redirect '/welcome'
  end

  get '/resource/:name' do
    redirect @content.resource_url(params[:name])
  end

  get '/index' do
    @presenter.present_index
  end

  get '/:post' do
    @reporter.report request
    @presenter.present_post params[:post]
  end
end
