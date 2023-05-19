class Genre < ApplicationRecord
has_many :items dependnet: :destroy  
end
