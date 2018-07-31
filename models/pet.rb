class Pet < ActiveRecord::Base
    # has_many :tags
    belongs_to :category
    # serialize :tags, Array
end