class Item < ActiveRecord::Base
  named_scope :active, :conditions => ['is_active = ?', true]
  named_scope :inactive, :conditions => ['is_active = ?', false]
  named_scope :price_higher_than, lambda { |p| { :conditions => ['price > ?', p] } }
  named_scope :created_later_than, lambda { |date| { :conditions => ['created_at > ?', date] } }
  
end