class Reporter
  def initialize application, report
    @application = application
    @report = report
  end

  def report
    Thread.new do
      response = RestClient.get "https://freegeoip.net/json/#{origin}"
      location = JSON.parse(response.body)
      @report.add location, DateTime.now
    end
  end

  def origin 
   if @application.env['HTTP_X_FORWARDED_FOR']
     @application.env['HTTP_X_FORWARDED_FOR'].split(',').last.strip
   else
     @application.request.ip
   end
  end
end
