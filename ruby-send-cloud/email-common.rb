#!/usr/bin/env ruby

require 'rubygems'
require 'rest_client'

$email_tables = ""
File.open("./email_tables.txt", 'rb') do |line|
	while email = line.gets
		$email_tables += email
	end
end

$html_content = ""
File.open("./template.html", 'rb') do |line|
	while code = line.gets
		$html_content += code
	end
end

def send_mail
        response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send.json",
		:myfile => File.new("./email-common.rb", 'rb'),
        :api_user => 'JieTrancender', # 使用api_user和api_key进行验证
        :api_key => '5CuJE56Bn9QNzNW9',
        :from => "jie-email@jie-trancender.org", # 发信人，用正确邮件地址替代
        :fromname => "JieTrancender",
        #:to => "jie-email@jie-trancender.org;582865471@qq.com;1113586525@qq.com", # 收件人地址，用正确邮件地址替代，多个地址用';'分隔
		:to => $email_tables,
		#:to => File.new("./to_email.txt", 'rb').gets,
        :subject => "来自jie-trancender.org的一封邮件！",
        #:html => '恭喜你！你已成功成为JieTrancender的会员，接下来快登录前台去查看账户信息吧！'
		#:html => '<a href = "http://www.jie-trancender.org:3000">JieTrancender</a>'
		#:html => File.new("./template.html", 'rb').gets
		:html => $html_content

return response
end

response = send_mail
puts response.code
puts response.to_str
puts $email_tables
