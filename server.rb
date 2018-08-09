# gem dependencies
require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

# models
require './models/category.rb'
require './models/pet.rb'
require './models/tag.rb'

before do
    content_type 'application/json'
end

get '/v2' do
    resp_obj = {:message => 'Please revisit documentation for this API: http://petstore.swagger.io'}
    return JSON.generate(resp_obj)
end

post '/v2/pet' do
    # working variables
    return_errors = []
    post_body = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    create_pet = Pet.create(:name => post_body[:name], :status => post_body[:status])
    
    # handle photo url validation and map
    if post_body[:photoUrls].kind_of?(Array)
        create_pet[:photoUrls] = post_body[:photoUrls]
    else
        return_errors << "Please ensure photoUrls are sent as part of an array"
    end

    # handle category validation, create and map
    if post_body[:category] != nil
        if Category.exists?(post_body[:category]["id"])
            stored_category = Category.find(post_body[:category]["id"])
            if stored_category[:name] == post_body[:category]["name"].downcase
                create_pet.category = stored_category
            else
             return_errors << "Please verify the category id submitted matches the name" 
            end
        else
            # v3 - This should be mapped to a seperate API call
            new_category = Category.new
            new_category[:name] = post_body[:category]["name"].downcase
            new_category.save

            create_pet.category = new_category
        end
    else
        return_errors << "Please verify the category object is correctly constructed"
    end

    # v3 - This should be a seperate API call, referenced instead of hard coded
    if post_body[:tags] != nil
        if post_body[:tags].is_a?(Array)
            holder_array = []
            post_body[:tags].each do |tag|
                holder_array << tag.to_json
            end
            create_pet[:tags] = holder_array
        else
            return_errors << "Tags must be sent as part of an array"
        end
    end

    # save pet and return status
    if return_errors != []
        content_type :json
        return 405, {status => 405, :message => return_errors}.to_json
    elsif create_pet.save
        content_type :json
        return 200, {:status => 200, :message => create_pet}.to_json
    else
        content_type :json
        return 500, {:status => 500, :message => "Server error - please contact the system administrator"}.to_json
    end
end

get '/v2/pet/:id' do
    return_errors = []
    id_param = params[:id].to_i
    return_pet = nil

    # perform id is integer check
    if id_param == 0
        return_errors << "Please submit a valid id"
        return 400, {:status => 400, :message => return_errors}.to_json
    elsif Pet.exists?(id_param)
        return_pet = Pet.find(id_param)
    else
        return_errors << "Pet not found"
    end
    
    if return_pet
        return 200, {:status => 200, :message => return_pet}.to_json
    else
        return 404, {:status => 404, :message => return_errors}.to_json
    end
end

put '/v2/pet' do
    return_errors = []
    update_pet = nil
    post_body = JSON.parse(request.body.read).symbolize_keys unless params[:path]
    
    # check pet exists
    if Pet.exists?(post_body[:id])
        update_pet = Pet.find(post_body[:id])

        # update name
        update_pet[:name] = post_body[:name]

        # update status
        update_pet[:status] = post_body[:status]

        # update photoURls
        if post_body[:photoUrls].kind_of?(Array)
            update_pet[:photoUrls] = post_body[:photoUrls]
        else
            return_errors << "Please ensure photoUrls are sent as part of an array"
        end

        # update category (validate)
        if post_body[:category] != nil
            # Could this be broken out into a class level method?
            if Category.exists?(post_body[:category]["id"])
                stored_category = Category.find(post_body[:category]["id"])
                if stored_category[:name] == post_body[:category]["name"].downcase
                    update_pet.category = stored_category
                else
                 return_errors << "Please verify the category id submitted matches the name" 
                end
            else
                # v3 - This should be mapped to a seperate API call
                new_category = Category.new
                new_category[:name] = post_body[:category]["name"].downcase
                new_category.save
    
                update_pet.category = new_category
            end
        else
            return_errors << "Please verify the category object is correctly constructed"
        end

        # update tags
        if post_body[:tags] != nil
            if post_body[:tags].is_a?(Array)
                holder_array = []
                post_body[:tags].each do |tag|
                    holder_array << tag.to_json
                end
                update_pet[:tags] = holder_array
            else
                return_errors << "Tags must be sent as part of an array"
            end
        end
    else
        return_errors << "Invalid ID supplied"
    end
    
    # if no errors, save
    if return_errors != []
        return_errors.each do |error|
            if error == "Invalid ID supplied"
                content_type :json
                return 400, {status => 400, :message => return_errors}.to_json
            else
                content_type :json
                return 405, {status => 405, :message => return_errors}.to_json
            end
        end
    elsif update_pet.save
        content_type :json
        return 200, {:status => 200, :message => update_pet}.to_json
    else
        content_type :json
        return 500, {:status => 500, :message => "Server error - please contact the system administrator"}.to_json
    end
end