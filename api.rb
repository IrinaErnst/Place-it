require 'sinatra'
require 'json'

class API < Sinatra::Base

	get '/' do
  	'<html><body><h1>Place-it!</h1></body></html>'
  end

  # Test locally w/ 'curl -i http://localhost:5000/rooms.json'
  get '/rooms.json' do
    content_type :json
    
    {:rooms => [
                 {:id => 1, :name => "Conference Room", :beacon_id => "B9407F30-F5F8-466E-25556B57FE6D", :maj_val => 21137, :min_val => 30314},
                 {:id => 2, :name => "Class Room", :beacon_id => "B9407F30-F5F8-AFF9-25556B57FE6D", :maj_val => 61334, :min_val => 32857}
                ]}.to_json
  end

end
