require 'test/unit'

module Rack
  module Unit
    class TestCase < ::Test::Unit::TestCase
      attr_reader   :response
      attr_accessor :request

      # Performs a GET request with the given path and headers.
      def get(path, headers = {})
        process :get, path, headers
      end

      # Performs a POST request with the given path and headers.
      def post(path, headers = {})
        process :post, path, headers
      end

      # Performs a PUT request with the given path and headers.
      def put(path, headers = {})
        process :put, path, headers
      end

      # Performs a DELETE request with the given path and headers.
      def delete(path, headers = {})
        process :delete, path, headers
      end

      # Performs a HEAD request with the given path and headers.
      def head(path, headers = {})
        process :head, path, headers
      end

      # Assert the status of the current response
      #
      # Example:
      #   assert_response 200
      #   assert_response 301..302
      #   assert_response :success
      #   assert_response :redirect
      #   assert_response :client_error
      #   assert_response :not_found
      #   assert_response :unprocessable_entity
      #   assert_response :server_error
      def assert_response(status, message = nil)
        case status
        when Fixnum
          assert_equal response.status, status, message
        when Range
          assert status.to_a.include?(response.status), message
        when :success
          assert_response 200, message
        when :redirect
          assert_response 301..302, message
        when :client_error
          assert_response 400, message
        when :not_found
          assert_response 404, message
        when :unprocessable_entity
          assert_response 412, message
        when :server_error
          assert_response 500, message
        end
      end

      # Assert to be redirected to the given path
      #
      # Example:
      #   assert_redirected_to "/projects/sashimi"
      def assert_redirected_to(path, message = nil)
        assert_response :redirect, message
        assert_equal response.header["Location"], path, message
      end

      def env #:nodoc:
        @rack_env ||= { "rack.env" => "test", "REMOTE_ADDR" => "127.0.0.1" }
      end

      def response=(response) #:nodoc:
        @response = Rack::Response.new(response[2], response[0], response[1])
      end

      def default_test #:nodoc:
      end

      protected
        def app
          raise "Should be implemented by subclasses!"
        end

        def process(method, path, headers = {}) #:nodoc:
          env.merge!(headers).merge!({ "REQUEST_METHOD" => method.to_s.upcase, "PATH_INFO" => path })
          self.request = Rack::Request.new(env)
          self.response = app.call(env)
        end
    end
  end
end
