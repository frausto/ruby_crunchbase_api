# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Organization < ModelBase
    endpoint 'organizations'

    def date_keys
      %w(founded_on closed_on)
    end
  end
end
