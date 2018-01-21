# frozen_string_literal: true
require 'singleton'
require 'time'

require 'json'
require 'crunchbase/exception'
require 'crunchbase/api'
require 'crunchbase/search'
require 'crunchbase/model'

module Crunchbase
  API_VERSION     = '3.1'
  API_BASE_URL    = "https://api.crunchbase.com/v#{API_VERSION}"
  WEB_SITE_URL    = 'https://www.crunchbase.com'
  IMAGE_URL       = 'https://res.cloudinary.com/crunchbase-production/'

  class << self
  end
end
