class Genre < ApplicationRecord
has_many :items, dependnet: :destroy  
has_many :items, dependent: :destroy
has_many :items, dependnet: :destroy  
has_many :items, dependent: :destroy

end
