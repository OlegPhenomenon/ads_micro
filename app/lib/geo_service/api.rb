module GeoService
  module Api
    def geo_data(city)
      begin
        uri = URI.parse("/geo?city=#{city}")
      rescue URI::InvalidURIError
        uri = URI.parse(URI.escape("/geo?city=#{city}"))
      end
      
      response = connection.get(uri)

      response.body if response.success?
    end
  end
end