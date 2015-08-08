class Branding
  def initialize(params)
    @color = params[:color] || 'D75F03'
  end

  def color
    '#' + @color
  end
end
