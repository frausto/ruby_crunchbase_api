# frozen_string_literal: true
require 'singleton'
require 'time'
require 'json'
require 'crunchbase/version'
require 'crunchbase/exception'
require 'crunchbase/api'
require 'crunchbase/search'
require 'crunchbase/model/base'

#models
require 'crunchbase/model/acquisition'
require 'crunchbase/model/address'
require 'crunchbase/model/category'
require 'crunchbase/model/degree'
require 'crunchbase/model/fund'
require 'crunchbase/model/funding_round'
require 'crunchbase/model/image'
require 'crunchbase/model/investment'
require 'crunchbase/model/ipo'
require 'crunchbase/model/job'
require 'crunchbase/model/location'
require 'crunchbase/model/news'
require 'crunchbase/model/organization'
require 'crunchbase/model/organization_summary'
require 'crunchbase/model/person'
require 'crunchbase/model/person_summary'
require 'crunchbase/model/video'
require 'crunchbase/model/website'

module Crunchbase
  API_VERSION     = '3.1'
  API_BASE_URL    = "https://api.crunchbase.com/v#{API_VERSION}"
  WEB_SITE_URL    = 'https://www.crunchbase.com'
  IMAGE_URL       = 'https://res.cloudinary.com/crunchbase-production/'

  class << self
  end
end
