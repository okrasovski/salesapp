class Product < ApplicationRecord


  #attr_accessible :id, :name, :price, :sales_amount, :sum_total, :last_sale_at, :sources
  #has_many :sources
  #attr_accessor :sources
  #accepts_nested_attributes_for :sources
  
  scope :ordered, -> {order("id")}
  scope :registry, -> {where("id IS NOT NULL")} #override '.all'
  scope :top, -> {registry.reverse_order}
  

end
