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
                 {:id => B9407f30F5F8466EAFF925556b57FE6D, :name => "Conference Room", 
                  :beacon_id => "abc123", :maj_val => 1, :min_val => 1},
                 {:id => B9407F30F5F8466EAFF925556B57FE6D, :name => "Class Room", 
                  :beacon_id => "abc123", :maj_val => 1, :min_val => 2}
                ]}.to_json
  end

end
