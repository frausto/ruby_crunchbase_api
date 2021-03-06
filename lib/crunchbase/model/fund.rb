# frozen_string_literal: true
# encoding utf-8

module Crunchbase::Model
  class Fund < Base
    endpoint 'funds'

    def date_keys
      %w(announced_on)
    end
  end
end
