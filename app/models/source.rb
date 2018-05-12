class Source < ApplicationRecord

  scope :ordered, -> {order("id")}
  scope :registry, -> {where("id IS NOT NULL")} #override '.all'
  scope :top, -> {registry.reverse_order}
end
