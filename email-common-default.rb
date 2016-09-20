#!/usr/bin/env ruby

require 'rubygems'
require 'rest_client'

def send_mail
        response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send.json",
        :api_user => 'JieTrancender', # 使用api_user和api_key进行验证
        :api_key => '5CuJE56Bn9QNzNW9',
        :from => "jie-email@jie-trancender.org", # 发信人，用正确邮件地址替代
        :fromname => "JieTrancender",
        :to => "jie-email@jie-trancender.org;582865471@qq.com", # 收件人地址，用正确邮件地址替代，多个地址用';'分隔
        :subject => "来自jie-trancender.org的一封邮件！",
        :html => '恭喜你！你已成功成为JieTrancender的会员，接下来快登录前台去查看账户信息吧！'

return response
end

response = send_mail
puts response.code
puts response.to_str
