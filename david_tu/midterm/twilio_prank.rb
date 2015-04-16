require 'twilio-ruby'
require 'pry'
require 'rubygems'
require 'sinatra'

account_sid = "ACbfc9a8577180048d31477bbad5ab4c71"
auth_token = "0f44562d8351e6d1864dc7c17a10031a"
@client = Twilio::REST::Client.new account_sid, auth_token

prank = true 

while prank == true
puts "Please enter a phone number if you want to prank:"

recipient = gets
from = "15102294543"

message = @client.account.messages.create(
    :body => "We're so glad you're coming to our wedding! Help us put together a playlist by texting us a song of your choice.",
    :to => recipient,
    :from => from
    )

puts "Do you want to prank text anyone else? Type exit if you are done."
prank = false if gets.strip == "exit"

end

puts message.to

messages = @client.account.messages.list.each do |message|
    message.body
end

puts messages

get '/' do
  @client = Twilio::REST::Client.new(account_sid, auth_token)
  @messages = @client.account.messages.list.map do |message|
   message.body
end

erb :home

end