require_relative "../../server.rb"
require 'minitest/autorun'
require 'active_record'
require 'rack/test'
require "pry"

# # Describe a Pet
# Create
# It has a name as a string requirement to save
# It has a status requirement to save that is available or unavailable
# It has a category object that matches a valid Category definition requirement to save
# It has a set of tags, stored in an array as individual objects requirement to save

# # Find
# # Factory
# It has a valid factory

# RSpec.describe Pet do
#     context 'when creating,' do
#         it 'name cannot be blank' do
#             Pet.create(name: nil).invalid?
#         end

#         it 'name must be a string' do
#             Pet.create(name: 1, status: "aviailable").invalid?
#             Pet.create(name: "Trixie", status: "aviailable").valid?
#         end
#     end

#     context 'when using the factory,' do
#         it 'can create a new pet with a random name' do
#             # pet = build(:name)
#         end
#     end
# end

class PetTest < ActiveSupport::TestCase
    def test_create
        pet = Pet.create(:name => "Trixie", :status => "available")
        assert_equal "Trixie", pet.name
    end
end