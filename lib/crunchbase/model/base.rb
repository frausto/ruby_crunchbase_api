# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Base

    attr_accessor :raw_data, :meta_data, :relationships, :properties, :type, :uuid

    def date_keys
      []
    end

    def method_missing(m, *args, &block)
      if !@properties.nil? && @properties.has_key?(m.to_s)
        return @properties[m.to_s]
      end
      raise ArgumentError.new("Method `#{m}` doesn't exist.")
    end

    def initialize(json)
      if json.has_key?("data")
        @meta_data = json["meta_data"]
        json = json["data"] || {}
      end
      
      @type = json["type"]
      @uuid = json["uuid"]
      @relationships = json['relationships']
      @properties = json['properties']
      %w(created_at updated_at).each do |v|
        @properties[v] = convert_date!(@properties[v])
      end
      date_keys.each do |v|
        if !@properties[v].nil? && !@properties[v].empty?
          @properties[v] = Date.parse(@properties[v])
        end
      end
    end
    
    def convert_date!(date)
      return Time.parse(date) if date.is_a?(String)
      Time.at(date)
    rescue
      nil
    end
    
    class << self
      def endpoint(var)
        @endpoint_var = var.to_s
      end

      def get(id)
        res = API.get("#{Crunchbase::API_BASE_URL}/#{super_class_endpoint}/#{id}")
        new(res)
      end

      def search(query={})
        ::Crunchbase::Search.search("#{Crunchbase::API_BASE_URL}/#{super_class_endpoint}", query)
      end

      def super_class_endpoint
        if @endpoint_var.nil? || @endpoint_var.empty?
          raise Exception, "no endpoint for request object #{superclass.class}"
        end
        @endpoint_var
      end
    end
  end
end
