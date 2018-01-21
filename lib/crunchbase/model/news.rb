# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class News < Base
    endpoint 'news'

    def date_keys
      %w(posted_on)
    end
  end
end
