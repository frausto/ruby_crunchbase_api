# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  module Model
    class Person < Base
      endpoint 'people'

      def date_keys
        %w(born_on died_on)
      end

      def full_name
        [first_name, last_name].compact.join(' ')
      end
    end
  end
end
