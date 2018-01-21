# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class FundingRound < Base
    endpoint 'funding-rounds'

    def date_keys
      %w(announced_on closed_on)
    end
  end
end
