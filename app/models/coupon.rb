class Coupon < ApplicationRecord  
  include PgSearch::Model
  has_and_belongs_to_many :products

  pg_search_scope :search_coupons, :against => [:name, :discount, :id]

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |coupon|
        csv << coupon.attributes.values_at(*column_names) 
      end
    end
  end  
end
