# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Degree < Base
    endpoint 'degrees'

    def date_keys
      %w(started_on completed_on)
    end
  end
end
