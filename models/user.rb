class User < ActiveRecord::Base
    # belongs_to :category

    validates :name, presence: true
    validates :location, presence: true
end