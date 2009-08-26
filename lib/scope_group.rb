# ScopeGroup
module ActiveRecord
  module NamedScoope
    module Group
      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end
      
      module ClassMethods
        def run_scope_group(groups)
          scope = groups.shift
          if groups.empty?
              self.send(scope[0], scope[1])
          else
            with_scope :find => self.send(scope[0], scope[1]).proxy_options do
              run_scope_group(groups)
            end
          end
        end        
      end
    end
  end
end

class ScopeGroup
  # init with an activerecord class.
  def initialize(klass)
    @klass = klass
    @group = []
  end
  
  def append_scope(scope_name, *args)
    if @klass.scopes.include?(scope_name.to_sym)
      @group << [scope_name, args]
    end
  end
  
  def method_missing(method, *args, &block)
    unless @klass.scopes.include?(method)
      @klass.run_scope_group(@group.dup).send(method, *args)
    else
      @group << [method, args]
    end
  end
end

ActiveRecord::Base.send :include, ActiveRecord::NamedScoope::Group