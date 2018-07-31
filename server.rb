require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

current_dir = Dir.pwd
Dir["#{current_dir}/models/*.rb"].each { |file| require file }

get '/' do
    resp_obj = {:message => 'Please revisit documentation for this API: http://petstore.swagger.io'}
    return JSON.generate(resp_obj)
end

post '/pet' do
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
            if stored_category[:name] == post_body[:category]["name"]
                create_pet.category = stored_category
            else
             return_errors << "Please verify the category id submitted matches the name" 
            end
        else
            # This should be mapped to a seperate API call v3
            new_category = Category.new
            new_category[:name] = post_body[:category]["name"]
            new_category.save

            create_pet.category = new_category
        end
    else
        return_errors << "Please verify the category object is correctly constructed"
    end

    if post_body[:tags] != nil
        if post_body[:tags].is_a?(Array)
            holder_array = []
            post_body[:tags].each do |tag|
                holder_array << tag.to_json
                # binding.pry
            end
            create_pet[:tags] = holder_array
        else
            return_errors << "Tags must be sent as part of an array"
        end
    end

    # save pet and return status
    if return_errors != []
        content_type :json
        return 400, {status => 400, :message => return_errors}.to_json
    elsif create_pet.save
        content_type :json
        return 200, {:status => 200, :message => create_pet}.to_json
    else
        content_type :json
        return 500, {:status => 500, :message => "Internal server error - please contact the system administrator"}.to_json
    end
end

get '/pet/:id' do
    return_errors = []
    id_param = params[:id].to_i
    return_pet = nil

    if Pet.exists?(id_param)
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