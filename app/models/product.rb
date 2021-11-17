class Product < ApplicationRecord
   belongs_to :category
   
   has_rich_text :description
   has_and_belongs_to_many :coupons
   has_many_attached :main_images
   has_many :cart_items
   
   include PgSearch::Model

   pg_search_scope :search_products, against: [:title, :id]

   def self.to_csv
     CSV.generate do |csv|
        csv << column_names
        all.each do |product|
           csv << product.attributes.values_at(*column_names) 
         end
      end
   end  

end
