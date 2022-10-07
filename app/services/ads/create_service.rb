module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id
    option :geocoder_service, default: proc { GeocoderService::Client.new }

    attr_reader :ad

    # 36:12
    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      # geo_service = GeoService::Client.new
      # coord =  geo_service.geo_data(@ad.city)

      # if coord.present?
      #   @ad.lat = coord["data"]["lat"]
      #   @ad.lon = coord["data"]["lon"]
      # end

      if @ad.valid?
        @ad.save
        @geocoder_service.geocode_later(@ad)
      else
        fail!(@ad.errors)
      end
    end
  end
end