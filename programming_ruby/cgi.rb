require 'cgi'
cgi = CGI.new("html5")
cgi.header("type" => "text/html", "expires" => Time.now + 30)
cgi.out do
	cgi.html do
		cgi.head{cgi.title{"Hello World!"}} +
		cgi.body do
			cgi.pre do
				CGI::escapeHTML(
					"params: " + cgi.params.inspect + "\n" +
					"cookies:  " + cgi.cookies.inspect + "\n")
			end
		end
	end
end

