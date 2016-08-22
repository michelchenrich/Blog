class Content
  def initialize renderer
    @renderer = renderer
  end

  def index
    post 'index'
  end

  def post name
    content_request = RestClient.get "#{content_url}/#{name}.md"
    @renderer.render content_request.to_str
  end

  def page name
    index_thread = Thread.new { index }
    post_thread = Thread.new { post name }
    { index: index_thread.join.value, post: post_thread.join.value }
  end

  def resource_url name
    "#{content_url}/resource/#{name}"
  end

  def content_url
    ENV['CONTENT_URL']
  end
end
