require 'test/unit'

module Rack
  module Unit
    class TestCase < ::Test::Unit::TestCase
      attr_reader   :app, :response
      attr_accessor :request

      def env #:nodoc:
        @env ||= {}
      end

      # Performs a GET request with the given path and headers.
      def get(path, headers = {})
        process :get, path, headers
      end

      def response=(response) #:nodoc:
        @response = Rack::Response.new(response[2], response[0], response[1])
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

      def default_test #:nodoc:
      end

      protected
        def process(method, path, headers = {}) #:nodoc:
          env["REQUEST_METHOD"] = method.to_s.upcase
          env["PATH_INFO"] = path
          self.request = Rack::Request.new(env)
          self.response = app.call(env)
        end
    end
  end
end
