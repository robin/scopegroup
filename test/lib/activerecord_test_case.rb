require 'lib/activerecord_test_connector'

class ActiveRecordTestCase < Test::Unit::TestCase
  if defined?(ActiveSupport::Testing::SetupAndTeardown)
    include ActiveSupport::Testing::SetupAndTeardown
  end

  if defined?(ActiveRecord::TestFixtures)
    include ActiveRecord::TestFixtures
  end
  # Set our fixture path
  if ActiveRecordTestConnector.able_to_connect
    self.fixture_path = File.join(File.dirname(__FILE__), '..', 'fixtures')
    self.use_transactional_fixtures = true
  end

  def self.fixtures(*args)
    super if ActiveRecordTestConnector.connected
  end

  def run(*args)
    super if ActiveRecordTestConnector.connected
  end
end

ActiveRecordTestConnector.setup
