# encoding: UTF-8

class CreateDatabase < ActiveRecord::Migration

  def self.up
    enable_extension "hstore"
    

    create_table "products", :force => true do |t|
      t.text     "name",                        :null => false
      t.integer  "price"
      t.integer  "sales_amount", :default => 0
      t.integer  "sum_total",    :default => 0
      t.datetime "last_sale_at"
      t.hstore   "sources"
    end

    create_table "sales", :force => true do |t|
      t.hstore   "positions",                :null => false
      t.integer  "sale_sum", :default => 0
      t.datetime "timestamp"
      t.string  "user" :null => false
      t.integer "client_id"
    end

    create_table "sources", :force => true do |t|
      t.text    "name",        :null => false
      t.integer "reserve"
    end

    create_table "users", :force => true do |t|
      t.string    "name",                                                    :null => false
      t.string    "encrypted_password",     :limit => 128
      t.string    "reset_password_token"
      t.timestamp "reset_password_sent_at", :limit => 0
      t.timestamp "remember_created_at",    :limit => 0
      t.integer   "sign_in_count",                         :default => 0
      t.timestamp "current_sign_in_at",     :limit => 0
      t.timestamp "last_sign_in_at",        :limit => 0
      t.string    "current_sign_in_ip"
      t.string    "last_sign_in_ip"
      t.string    "authentication_token"
      t.timestamp "created_at",             :limit => 0
      t.timestamp "updated_at",             :limit => 0
      t.boolean   "is_manager",                            :default => false
      t.decimal   "sales_sum_total"
    end

  end



  def self.down

    # drop all the tables if you really need

    # to support migration back to version 0

  end

end
