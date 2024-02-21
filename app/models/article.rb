class Article < ApplicationRecord
    resourcify 
    belongs_to :user
    # def self.ransackable_attributes(auth_object = nil)
    #     ["body", "created_at", "id", "id_value", "title", "updated_at"]
    #   end
end
