# gem dependencies
require 'sinatra'
require 'sinatra/activerecord'
require 'pry'
require 'faker'

# models
require './models/user.rb'

before do
    content_type 'application/json'
end

# FUNC_PATHS

get '/kata/key' do
    status = 200
    message = "Please update your request"
    token = params[:token]
    id = params[:id]
    return_id = ""
    resp_obj = {:message => message}

    if token === nil && id === nil
        resp_obj = {:message => message}
    end

    if token === 'true' && id === nil
        message = "Token Generated"
        return_id = Random.new_seed
        resp_obj = {
            :status => status,
            :message => message,
            :token => return_id
        }
    end

    if token === nil && id === true
        message = "Please do not pass keys into the /key path"
    end

    return JSON.generate(resp_obj)
end

get '/ping' do
    if params[:isFinal] === 'true'
        return 200, JSON.generate({:status => 200, :message => "Greatest workshop ever!"})
    end
    
    return 200, JSON.generate({:status => 200, :message => "Ping successful"})
end

# KATA_CODE

get '/kata/1' do
    resp_obj = {:status=> 200, :message => 'Welcome to the Smartbear workshop at Catalyst!'}

    return JSON.generate(resp_obj)
end

get '/kata/2' do
    status = 200
    message = ""
    token = params[:token]
    id = params[:id]
    return_id = ""

    if token === nil && id === nil
        message = "Please update your request"
        resp_obj = {:message => message}

        return 404, JSON.generate(resp_obj)
    end

    if token === nil && id != nil
        message = "Success"

        resp_obj = {
            :status => status,
            :message => message
        }
    end

    return JSON.generate(resp_obj)
end

get '/kata/3' do
    status = 200
    message = "Success"
    id = params[:id]
    return_id = ""

    if id != nil
        random_number = Random.rand(1..2)
        if random_number == 1
            status = 500
            message = "Internal Server Error"

            resp_obj = {
                :status => status,
                :message => message
            }

            return 500, JSON.generate(resp_obj)
        end

        resp_obj = {
            :status => status,
            :message => message
        }
        return 200, JSON.generate(resp_obj)
    end

    return 404, JSON.generate({:status => 404, :message => "Please update your request"})
    
end

get '/kata/4' do
    status = 200
    message = "Success"
    id = params[:id]
    return_id = ""

    if id != nil
        random_number = Random.rand(1..2)
        if random_number == 1
            status = 500
            message = "Internal Server Error"

            resp_obj = {
                :status => status,
                :message => message
            }

            return 500, JSON.generate(resp_obj)
        end

        resp_obj = {
            :status => status,
            :message => message
        }
        return 200, JSON.generate(resp_obj)
    end

    return 404, JSON.generate({:status => 404, :message => "Please update your request"})
end

get '/kata/5' do
    status = 200
    message = "Success"
    payload = []
    id = params[:id]

    if id != nil
        number_of_objects = Random.rand(5..100)

        while payload.length < number_of_objects
            random_number = Random.rand(1..5)
            new_obj = {}
            if random_number === 1
                new_obj[:uuid] = Random.rand(1000..9999).to_s
                new_obj[:name] = Faker::StarWars.character
            elsif random_number === 2
                new_obj[:uuid] = Random.rand(1000..9999).to_s
            elsif random_number === 3 || random_number === 4 || random_number === 5
                new_obj[:uuid] = Random.rand(1000..9999).to_s
                new_obj[:name] = Faker::StarWars.character
                new_obj[:location] = Faker::StarWars.planet
            end

            payload << new_obj
        end

        return 200, JSON.generate({
            :status => 200, 
            :message => message,
            :payload => payload
        })
    end

    return 404, JSON.generate({:status => 404, :message => "Please update your request"})
end

post '/kata/6' do
    error_messages = []
    post_body = JSON.parse(request.body.read).symbolize_keys unless params[:path]

    if post_body[:uuid] === nil
        error_messages << "Please include a UUID in all POST bodies"
    end
    
    if post_body[:name] === nil
        error_messages << "Please include a name in all POST bodies"
    end
    
    if post_body[:location] === nil
        error_messages << "Please include a location in all POST bodies"
    end
    
    if error_messages === []
        return 201, JSON.generate({:status => 201, :message => 'Success'})
    end

    return 404, JSON.generate({:status => 404, :message => error_messages})
end
