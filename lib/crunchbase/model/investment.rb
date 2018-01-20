# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Investment < ModelBase
    endpoint 'investments'

    def date_keys
      %w(announced_on)
    end

  end
end
