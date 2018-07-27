class Pet < ActiveRecord::Base
    has_many :tags
    has_many :categories
end