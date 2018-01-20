# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  class Search

    ORDER_CREATED_AT_ASC  = 'created_at ASC'
    ORDER_CREATED_AT_DESC = 'created_at DESC'
    ORDER_UPDATED_AT_ASC  = 'updated_at ASC'
    ORDER_UPDATED_AT_DESC = 'updated_at DESC'

    attr_reader :total_items, :per_page, :pages, :current_page, :prev_page_url, :next_page_url, :sort_order, :items, :key_set_url

    def initialize(result)
      json = result["data"]
      @items = []
      @items = json['items'].map do |r|
        o = Object.const_get("Model::#{r["type"]}")
        o.new(r)
      end

      @total_items      = json['paging']['total_items']
      @per_page         = json['paging']['items_per_page']
      @pages            = json['paging']['number_of_pages']
      @current_page     = json['paging']['current_page']
      @prev_page_url    = json['paging']['prev_page_url']
      @next_page_url    = json['paging']['next_page_url']
      @key_set_url    = json['paging']['key_set_url']
      @sort_order       = json['paging']['sort_order']
    end

    def next
      self.class.search(@key_set_url)
    end

    def prev_page
      self.class.search(@prev_page_url)
    end

    def next_page
      self.class.search(@next_page_url)
    end

    def self.search(uri, query_params={})
      query_params[:sort_order] ||= ORDER_CREATED_AT_DESC
      self.new(API.get(uri, query_params))
    end
  end
end
