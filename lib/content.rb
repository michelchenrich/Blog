class Content
  def page name
    content_request = RestClient.get "#{ENV['CONTENT_URL']}/#{name}"
    content_request.to_str
  end
end
