require 'net/http'
require 'openssl'

module QQBot
	class Client
		@@user_agent = 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:51.0) Gecko/20100101 Firefox/51.0'

		attr_accessor :cookie

		def self.origin(uri)
			"#{uri.scheme}://#{uri.host}"
		end

		def initialize
			@cookie = QQBot::Cookie.new
		end

		def get(uri, referer = '')
			QQBot::LOGGER.debug{"get #{uri.to_s}"}

			Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https',
				verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
				req = Net::HTTP::GET.new(uri)
				req.initialize_http_header(
					'User-Agent' => @@user_agent,
					'Cookie' => @cookie.to_s,
					'Referer' => referer
				)
				res = http.request(req)
				@cookie.put(res.get_fields('set-cookie'))
				QQBot::LOGGER.debug{"code: #{res.code}, body: #{res.body}"}
				return res.code, res.body
			end
		end