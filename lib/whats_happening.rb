# environment
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative './whats_happening/version'
require_relative './whats_happening/cli'
require_relative './whats_happening/scraper'
require_relative './whats_happening/celebration'
require_relative './whats_happening/month'
require_relative './whats_happening'


module WhatsHappening
  class Error < StandardError; end
  # Your code goes here...
end
