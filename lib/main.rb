require_relative './libraries'
require_relative './session'
require_relative './content'
require_relative './presenter'

class Main < Sinatra::Application
  set sessions: true

  before do
    @session = Session.new self
    @content = Content.new
    @presenter = Presenter.new
  end

  get '/' do
    redirect('/first_post')
  end

  get '/:page_name' do
    page = @content.page params[:page_name]
    erb(:index) { @presenter.present page }
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
