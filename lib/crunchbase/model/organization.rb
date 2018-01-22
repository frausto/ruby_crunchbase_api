# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Organization < Base
    endpoint 'organizations'

    relations %w(primary_image founders featured_team current_team past_team board_members_and_advisors
        investors owned_by sub_organizations headquarters offices categories
        funding_rounds investments acquisitions acquired_by
        ipo funds websites images news)

    def date_keys
      %w(founded_on closed_on)
    end
  end
end
