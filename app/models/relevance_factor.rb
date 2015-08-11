# A factor used in weighting a value for computing a relevance value
class RelevanceFactor
  include ValueObject.new(:weight, :value)
end
