class Product < ApplicationRecord
   belongs_to :category, optional: true

   has_rich_text :description

   has_and_belongs_to_many :coupons
   has_many :cart_items, dependent: :destroy
   has_many :order_items

   has_many_attached :main_images
   
   include PgSearch::Model

   def to_bilder
      Jbuilder.new do |product|
        product.price = Stripe_price_id
      end
   end

   pg_search_scope :search, against: [:title, :id]

   def self.to_csv
     CSV.generate do |csv|
        csv << column_names
        all.each do |product|
           csv << product.attributes.values_at(*column_names) 
         end
      end
   end  

end
