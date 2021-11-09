class Product < ApplicationRecord
   has_rich_text :description
   
   include PgSearch::Model

   pg_search_scope :search_products, :against => [:title]

   def self.to_csv
      CSV.generate do |csv|
         csv << column_names
         all.each do |product|
            csv << product.attributes.values_at(*column_names) 
         end
      end
   end  
end
