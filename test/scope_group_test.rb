require 'test_helper'
require 'lib/activerecord_test_case'

require 'scope_group'

class ScopeGroupTest < ActiveRecordTestCase
  fixtures :items
  # Replace this with your real tests.
  def test_scope_group
    scope_group = ScopeGroup.new Item
    scope_group.active
    assert_equal(2, Item.active.count)
    assert_equal(2, scope_group.count)
    assert_in_delta(1.5, scope_group.average(:price).to_f, 2 ** -20)
    scope_group.price_higher_than(1.5)
    assert_equal(1, Item.active.price_higher_than(1.5).count)
    assert_equal(1, scope_group.count)
    assert_in_delta(2.0, scope_group.average(:price).to_f, 2 ** -20)
  end
  
  def test_append_group
    scope_group = ScopeGroup.new Item
    scope_group.append_scope('active')
    assert_equal(2, Item.active.count)
    assert_equal(2, scope_group.count)
    assert_in_delta(1.5, scope_group.average(:price).to_f, 2 ** -20)
    scope_group.append_scope('price_higher_than', 1.5)
    assert_equal(1, Item.active.price_higher_than(1.5).count)
    assert_equal(1, scope_group.count)    
    assert_in_delta(2.0, scope_group.average(:price).to_f, 2 ** -20)
  end
  
end
