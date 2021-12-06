class Coupon < ApplicationRecord
  include PgSearch::Model
  has_and_belongs_to_many :products

  TYPE = [:percentage, :cash].freeze
  enum type: TYPE

  pg_search_scope :search, against: [:name, :discount, :id]

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |coupon|
        csv << coupon.attributes.values_at(*column_names)
      end
    end
  end
end
