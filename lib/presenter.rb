class Presenter
  def initialize application, content
    @application = application
    @content = content
  end

  def present_index
    if is_mobile?
      @application.erb :mobile_index, locals: { index: @content.index }
    else
      @application.redirect '/welcome'
    end
  end

  def present_post name
    if is_mobile?
      @application.erb :mobile_post, locals: { post: @content.post(name) }
    else
      @application.erb :full_page, locals: @content.page(name)
    end
  end

  def is_mobile?
    @application.request.env['X_MOBILE_DEVICE']
  end
end
