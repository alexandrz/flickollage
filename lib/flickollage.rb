require 'flickraw'
require 'mini_magick'

module Flickollage
  class Error < StandardError; end
  class << self
    attr_accessor :logger

    def init_logger(options = {})
      Flickollage.logger = ::Logger.new(STDOUT).tap do |logger|
        logger.level = options[:verbose] ? ::Logger::DEBUG : ::Logger::INFO
        logger.formatter = proc do |_severity, _datetime, _progname, msg|
          "#{msg}\n"
        end
      end
    end

    def configure_flickraw(options)
      FlickRaw.api_key = ENV['FLICKR_API_KEY'] || options[:flickr_api_key]
      FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET'] || options[:flickr_shared_secret]
      return true if FlickRaw.api_key && FlickRaw.shared_secret
      raise Error, 'Flickr configuration is not provided.'
    end
  end
end

require 'flickollage/logger.rb'
require 'flickollage/dictionary.rb'
require 'flickollage/image.rb'
require 'flickollage/collage.rb'
require 'flickollage/cli.rb'
