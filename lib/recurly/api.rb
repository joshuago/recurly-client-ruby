module Recurly
  # The API class handles all requests to the Recurly API. While most of its
  # functionality is leveraged by the Resource class, it can be used directly,
  # as well.
  #
  # Requests are made with methods named after the four main HTTP verbs
  # recognized by the Recurly API.
  #
  # @example
  #   Recurly::API.get 'accounts'             # => #<Net::HTTPOK ...>
  #   Recurly::API.post 'accounts', xml_body  # => #<Net::HTTPCreated ...>
  #   Recurly::API.put 'accounts/1', xml_body # => #<Net::HTTPOK ...>
  #   Recurly::API.delete 'accounts/1'        # => #<Net::HTTPNoContent ...>
  class API
    require 'recurly/api/errors'

    @@base_uri = "https://api.recurly.com/v2/"

    class << self
      # @return [String]
      attr_accessor :accept_language

      # @return [Net::HTTPOK, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def head uri, params = {}, options = {}
        request :head, uri, { :params => params }.merge(options)
      end

      # @return [Net::HTTPOK, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def get uri, params = {}, options = {}
        request :get, uri, { :params => params }.merge(options)
      end

      # @return [Net::HTTPCreated, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def post uri, body = nil, options = {}
        request :post, uri, { :body => body.to_s }.merge(options)
      end

      # @return [Net::HTTPOK, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def put uri, body = nil, options = {}
        request :put, uri, { :body => body.to_s }.merge(options)
      end

      # @return [Net::HTTPNoContent, Net::HTTPResponse]
      # @raise [ResponseError] With a non-2xx status code.
      def delete uri, options = {}
        request :delete, uri, options
      end

      # @return [URI::Generic]
      def base_uri
        URI.parse @@base_uri
      end

      # @return [String]
      def user_agent
        "Recurly/#{Version}; #{RUBY_DESCRIPTION}"
      end

      private

      def accept
        'application/xml'
      end
      alias content_type accept
    end
  end
end

require 'recurly/api/net_http_adapter'
