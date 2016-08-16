class Session
  def initialize application
    @application = application
  end

  def exists?
    @application.session[:logged_in]
  end

  def log_in
    @application.session[:logged_in] = true
  end

  def log_out
    @application.session[:logged_in] = false
  end
end
