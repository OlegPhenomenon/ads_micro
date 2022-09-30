module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      geo_service = GeoService::Client.new
      coord =  geo_service.geo_data(@ad.city)

      if coord.present?
        @ad.lat = coord["data"]["lat"]
        @ad.lon = coord["data"]["lon"]
      end

      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end
  end
end
