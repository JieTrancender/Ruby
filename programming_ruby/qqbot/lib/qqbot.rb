require 'logger'
require 'qqbot/version'

module QQBot
	class Logger < Logger
		def info(*args)
			super && false if info?
		end

		def debug(*args)
			super && false if debug?
		end
	end

	LOGGER = QQBot::Logger.new(STDOUT)
	LOGGER.datetime_format = '%Y-%m-%d %H::%M::%S'
	LOGGER.level = Logger::INFO

	CLIENT_ID = 53999199

	autoload :Cookie, 'qqbot/cookie'