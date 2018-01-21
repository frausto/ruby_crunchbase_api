# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  module Model
    class PersonSummary < Base
      endpoint 'people_summaries'

      def to_person
        Person.get(@properties.permalink)
      end

    end
  end
end
