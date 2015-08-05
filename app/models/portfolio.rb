# A presenter value object that provides convenience methods to access all the
# data needed to render a portfolio.
class Portfolio
  include ValueObject.new(:user)

  def name
    user.name
  end

  def serialize
    Marshal.dump(self)
  end

  def self.load(serialized_user)
    Marshal.load(serialized_user)
  end
end
