class Branding
  attr_reader :color

  def initialize(params)
    @color = "##{params[:color]}" || '#D75F03'
  end
end
