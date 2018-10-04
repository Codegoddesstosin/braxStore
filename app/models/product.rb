class Product < ActiveRecord::Base
    

    validates :title, presence: true 
    validates :price, presence: true  
    
    
    mount_uploader :image, ImageUploader
    
    
end
