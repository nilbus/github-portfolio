class Branding
  def initialize(params)
    @hue = params[:hue] || Rails.application.secrets[:hue] || 20
  end

  def color
    "hsl(#{@hue}, 97%, 43%)"
  end
end
