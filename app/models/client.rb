class Client < ActiveRecord::Base

  #attr_accessible :id, :join_at, :first_level_sales_sum, 
  # :second_level_sales_sum, :bonus_sum, :parent_id, :phone_number
  
  scope :ordered,-> {order("id")}
  scope :registry, -> {where("id IS NOT NULL")} #override '.all'
  scope :top, -> {ordered.reverse_order}
  
end
