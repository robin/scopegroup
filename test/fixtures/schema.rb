ActiveRecord::Schema.define do
    create_table :items, :force => true do |t|
      t.column "name", :string
      t.column "price", :float
      t.column "is_active", :bool
      t.column "created_at", :datetime
      t.column "updated_at", :datetime
    end
end