require 'sinatra'
require 'net/http'
require 'json'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def get_searched_count(key)
	url = "https://www.udemy.com/api-2.0/search-suggestions?q=#{key}"
	uri = URI(url)
	resposne = Net::HTTP.get(uri)
	udemy_hash = JSON.parse(resposne)
	key_count = udemy_hash["results"][0]["searched_count"]
	return "#{key}: #{key_count}"
end 


get '/' do
	"Error: No Search Term Provided"
end

get'/term=' do
	"Error: Search Term Empty"
end 

get'/term=:searched_key' do
	term = params["searched_key"]
	return "#{get_searched_count("#{term}")}"
end 