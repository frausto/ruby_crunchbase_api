# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class OrganizationSummary < Base
    endpoint 'organization_summaries'

    def to_org
      Organization.get(@properties.permalink)
    end
  end
end
