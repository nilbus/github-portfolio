# A GitHub user value object.
class User
  include ValueObject.new(:name, :login)
end
