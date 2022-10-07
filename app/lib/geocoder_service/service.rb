require 'dry/initializer'
require_relative 'api'

module GeocoderService
  class Client
    extend Dry::Initializer[undefined: false]
    include Api

    # option :url, default: proc { 'http://localhost:3010/v1' }
    # option :connection, default: proc { build_connection }
    option :queue, default: proc { create_queue }

    private

    def create_queue
      channel = RabbitMq.channel
      channel.queue('geocoding', durable: true)
    end

    def publish(payload, opts={})
      @queue.publish(
        payload,
        opts.merge(persistent: true, app_id: 'ads')
      )
    end

    # def build_connection
    #   Faraday.new(@url) do |conn|
    #     conn.request :json
    #     conn.response :json, content_type: /\bjson$/
    #     conn.adapter Faraday.default_adapter
    #   end
    # end
  end
end
