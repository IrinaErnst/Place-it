require 'sinatra'
require 'json'

class API < Sinatra::Base

	get '/' do
  	'<html><body><h1>Hello world!</h1></body></html>'
  end

  # Test locally w/ 'curl -i http://localhost:5000/rooms.json'
  get '/rooms.json' do
    content_type :json
    
    {:rooms => [
                 {:id => 1, :name => "Conference Room", :beacon_id => "abc123", :maj_val => 1, :min_val => 1},
                 {:id => 2, :name => "Class Room", :beacon_id => "abc123", :maj_val => 1, :min_val => 2}
                ]}.to_json
  end

end
