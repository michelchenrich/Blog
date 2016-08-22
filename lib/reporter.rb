class Reporter
  def initialize report
    @report = report
  end

  def report request
    Thread.new do
      response = RestClient.get "https://freegeoip.net/json/#{request.remote_ip}"
      location = JSON.parse(response.body)
      @report.add location, DateTime.now
    end
  end
end
