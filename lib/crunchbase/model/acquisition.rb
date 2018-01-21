# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Acquisition < Base
    endpoint 'acquisitions'
    
    def date_keys
      %w(announced_on completed_on)
    end
  end
end
