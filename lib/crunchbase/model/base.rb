# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Base

      CarnalityOto = "OneToOne"
      CarnalityOtm = "OneToMany"
      CarnalityMtm = "ManyToMany"
      CarnalityMto = "ManyToOne"

    attr_accessor :raw_data, :meta_data, :relationships, :properties, :type, :uuid, :relationship_keys

    def date_keys
      []
    end

    def method_missing(m, *args, &block)
      if !@properties.nil? && @properties.has_key?(m.to_s)
        return @properties[m.to_s] 
      end
      if !@relationships.nil? && @relationships.has_key?(m.to_s)
        return @relationships[m.to_s] 
      end
      # raise ArgumentError.new("Method `#{m}` doesn't exist.")
      puts "Method `#{m}` doesn't exist." if API.debug
      nil
    end

    def initialize(json)
      if json.has_key?("data")
        @meta_data = json["meta_data"]
        json = json["data"] || {}
      end
      
      @type = json["type"]
      @uuid = json["uuid"]
      
      @properties = ::Hashie::Mash.new(json['properties'])
      %w(created_at updated_at).each do |v|
        @properties[v] = convert_date!(@properties[v])
      end
      date_keys.each do |v|
        if !@properties[v].nil? && !@properties[v].empty?
          @properties[v] = Date.parse(@properties[v])
        end
      end
      @relationships = ::Hashie::Mash.new
      json['relationships'] ||= []
      json['relationships'].each do |key, val|
        if val.kind_of?(Array)
          val = {"cardinality" => "many", "items" => val}
        end
        @relationships[key] = if !val["cardinality"] || val["cardinality"] == CarnalityOto || val["cardinality"] == CarnalityMto
          r =  val["item"] ? val["item"] : val
          self.class.to_model(r)
        else
          val["items"].map do |r|
            self.class.to_model(r)
          end.compact
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

      def to_model(r)
        if r["type"]
          o = Object.const_get("Crunchbase::Model::#{r["type"]}")
          o.new(r)
        else
          nil
        end
      end

      def endpoint(var)
        @endpoint_var = var.to_s
      end

      def relations(var)
        @relationship_keys = var
      end

      def batch(list_o_things, manual_relations=[])
        manual_relations = @relationship_keys || [] if manual_relations.empty?
        request_query = {
          "requests" => list_o_things.map do |thang|
            {"type" => self.to_s.split("::").last, "uuid" => thang.uuid, "relationships" => manual_relations}
          end
        }
        res = ::Crunchbase::API.batch(request_query)
        ::Crunchbase::Search.new(res)
      end

      def get(id)
        res = ::Crunchbase::API.get("#{Crunchbase::API_BASE_URL}/#{super_class_endpoint}/#{id}")
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
