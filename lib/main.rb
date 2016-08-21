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
    @reporter = Reporter.new Report.new
  end

  get '/' do
    redirect('/welcome')
  end

  get '/mobile/index' do
    erb :mobile_index, locals: { index: @content.index }
  end

  get '/:post' do
    @reporter.report request
    if request.env['X_MOBILE_DEVICE']
      erb :mobile_post, locals: { post: @content.post(params[:post]) }
    else
      erb :full_page, locals: @content.page(params[:post])
    end
  end
end
