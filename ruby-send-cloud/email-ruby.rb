#!/usr/bin/env ruby

require 'rubygems'
require 'rest_client'
require 'json'

def send_mail
        vars = JSON.dump({"to" => ['582865471@qq.com'], "sub" => { "%code%" => ['123456']} })
        response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send_template.json",
        :api_user => "JieTrancender_test_DJB4se", # 使用api_user和api_key进行验证
        :api_key => "5CuJE56Bn9QNzNW9",
        :from => "jie-email@jie-trancender.org", # 发信人，用正确邮件地址替代
        :fromname => "SendCloud",
        :substitution_vars => vars,
        :template_invoke_name => 'test',
        :subject => "SendCloud ruby webapi template example",
        :resp_email_id => 'true'

return response
end

response = send_mail
puts response.code
puts response.to_str
