# A GitHub user value object.
class User
  include ValueObject.new(:name, :login)

  attr_accessor :name, :login
end
