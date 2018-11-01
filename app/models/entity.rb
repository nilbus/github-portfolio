# frozen_string_literal: true

# An enitity is mutable but may have no external side effects.
# The purpose of Entity classes is to hold data that has an identity.
#
# Usage:
#
#     class MyEntity
#       include Entity.new(:identity_attribute)
#       attr_accessor :identity_attribute, :other_mutable_attribute
#     end
#
# Entities may only use or return other classes that have no side effects.
#
# Entities are comparable and equal according to the identify attributes, not the
# object_id.
#
class Entity < Module
  def initialize(*equalizer_attributes)
    @equalizer_attributes = equalizer_attributes
    super()
  end

  def included(descendant)
    super
    include_modules(descendant)
    define_inspect(descendant)
  end

  def include_modules(klass)
    equalizer_attributes = @equalizer_attributes
    klass.send :include, Lift
    klass.send :include, Equalizer.new(*equalizer_attributes)
  end

  def define_inspect(klass)
    define_inspect_helper(klass)
    equalizer_attributes = @equalizer_attributes
    klass.send :define_method, :inspect do
      klass = self.class
      name = klass.name || klass.inspect
      attrs = (equalizer_attributes + _accessors_for_instance_variables).uniq
      "#<#{name}#{attrs.map { |attr| " #{attr}=#{__send__(attr).inspect}" }.join}>"
    end
  end

  def define_inspect_helper(klass)
    klass.module_eval do
      private

      define_method :_accessors_for_instance_variables do
        accessor_names = send(:instance_variable_names).map { |ivar| ivar[1..-1] }
        accessor_names.select { |accessor_name| respond_to?(accessor_name) }
      end
    end
  end
end
