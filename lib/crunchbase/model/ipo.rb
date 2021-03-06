# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Ipo < Base
    endpoint 'ipos'

    def date_keys
      %w(went_public_on)
    end
  end
end
