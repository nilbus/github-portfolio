# A factor used in weightinga value for computing a relevance value
class RelevanceFactor
  attr_accessor :name, :weight, :value_proc

  def self.calculate(factors)
    weighted_values = factors.map do |factor|
      value = factor.value_proc.call.to_f
      value = 0 if value.nan? || !value.finite?
      value * factor.weight.to_f
    end
    weighted_values.inject(:+) || 0
  end

  def initialize(name, weight, &value_proc)
    @name = name
    @weight = weight
    @value_proc = value_proc
  end
end
