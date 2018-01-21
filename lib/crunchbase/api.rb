# encoding: utf-8
# frozen_string_literal: true
require 'rest-client'

module Crunchbase
  class API

    @debug = false

    class << self
      attr_accessor :key, :debug

      def get(url, params={})
        raise Exception, 'User key required, visit https://data.crunchbase.com/v3.1/docs' unless @key
        params["user_key"] = @key
        query_params = URI.encode_www_form(params)
        url += "#{url =~ /\?/ ? '&' : '?'}#{query_params}"
        url = URI.decode(url)
        debug_request("get", url)
        response = ::RestClient.get(url, {}) do |response, request, result, &block|
          debug_response(response)
          case response.code
          when 200
            response
          else
            response.return!(&block)
          end
        end
        parse_result(response.body)
      end

      def batch(params)
        raise Exception, 'User key required, visit https://data.crunchbase.com/v3.1/docs' unless @key
        headers = {
         'X-Cb-User-Key' => @key,
         'Content-Type' => "application/json"
        }
        url = "#{API_BASE_URL}/batch"
        debug_request("post", url, headers, params)
        response = RestClient.post(url, params.to_json, headers) do |response, request, result, &block|
          debug_response(response)
          case response.code
          when 200
            response
          else
            response.return!(&block)
          end
        end
        parse_result(response.body)
      end

      def parse_result(json)
        if defined?(Oj)
          Oj.load(json)
        elsif defined?(Yajl)
          Yajl::Parser.parse(json)
        else
          JSON.parse(json)
        end
      end

      def debug_response(response)
        return unless debug
        puts 'Response'
        puts '*' * 140
        puts response.code
        puts response.body
        puts '*' * 140
      end

      def debug_request(req_method, uri, headers={}, body={})
        return unless debug
        puts 'Request'
        puts '*' * 140
        puts "*** #{req_method}: #{uri}  ***"
        puts "headers: #{headers.inspect}"
        puts "body: #{body.inspect}"
        puts '*' * 140
      end
    end
  end
end
