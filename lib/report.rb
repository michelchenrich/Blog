class Report
  def add location, time
    puts "View from #{location[:country_name]}-#{location[:city_name]} at #{time.to_s}"
  end
end
