

# gist.github.com/kyletcarlson/7911188
class JobsController < ApplicationController
  	# these are libraries of code
  	require 'open-uri'
	require 'json'
	require 'uri'
	require 'ap'

  def index

cities = ['Boston','San Francisco','Los Angeles','Denver','Boulder','Chicago','New York']
languages = ['Python','C++','C','Node','Scala','Ruby']
@totals = {}
i=0

cities.each do |city|
	@city = city
  url = "https://jobs.github.com/positions.json?location=#{@city}"
  json = JSON.parse(open(URI.escape(url)).read)
  city_count = json.count
  ap city_count
  languages.each do |language|
    url = "https://jobs.github.com/positions.json?description=#{language}&location=#{@city}"
    json = JSON.parse(open(URI.escape(url)).read)
    ap "Found #{json.count} #{language} jobs in #{@city} out of a total of #{city_count}"
    @totals[i] = {:city => @city, :language => language, :count => json.count, :percentage => (city_count == 0 ? 0 : json.count.to_f / city_count.to_f )}
    i += 1
  end
end
 ap @totals

end
end