require_relative './libraries'
require_relative './session'
require_relative './content'
require_relative './renderer'
require_relative './reporter'
require_relative './report'

class Main < Sinatra::Application
  set sessions: true

  before do
    @session = Session.new self
    @content = Content.new Renderer.new
    @report = Report.new
    @reporter = Reporter.new @report
  end

  get '/' do
    redirect('/welcome')
  end

  get '/mobile/index' do
    erb :mobile_index, locals: { index: @content.index }
  end

  get '/:post' do
    @reporter.report request
    page = @content.page params[:post]
    if request.env['X_MOBILE_DEVICE']
      erb :mobile_post, locals: page
    else
      erb :full_page, locals: page
    end
  end
end
