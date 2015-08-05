# A value object is immutable and may have no side effects.
# This allows value objects to be a worry-free dependency.
#
# Usage:
#
#     include ValueObject.new(:attribute1, :attribute2)
#     attr_accessor :attribute1, :attribute2
#
# Value objects may only use or return other classes that are also immutable and have
# no side effects.
#
# Value objects hold data, and provide methods to access that data or transformed
# versions of it.
#
# Value objects are comparable and equal according to the values they old, not the
# object_id.
#
class ValueObject < Module
  def initialize(*equalizer_attributes)
    @equalizer_attributes = equalizer_attributes
    super()
  end

  def included(descendant)
    super
    equalizer_attributes = @equalizer_attributes
    descendant.module_eval do
      include Adamantium
      include Lift
      include Equalizer.new(*equalizer_attributes)
      attr_accessor(*equalizer_attributes)
    end
  end
end
