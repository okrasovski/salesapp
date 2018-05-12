class Sale < ActiveRecord::Base

  #attr_accessible :id, :positions, :sale_sum, :timestamp, :user, :client_id

  #serialize :positions, ActiveRecord::Coders::Hstore
  #store_accessor :positions
  mount_uploader :qrcode, ImageUploader

  validates :positions, :timestamp, presence: true
  validates :sale_sum, numericality: {greater_than: 0}
  
  scope :ordered, -> {order("id")}
  #scope :registry, -> {where("id IS NOT NULL")} #override '.all'
  scope :top, -> {ordered.reverse_order}

  
end 
