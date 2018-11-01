# frozen_string_literal: true

# Generate colors for design customization.
#
# You may set the default color in secrets.yml. Eg. a blue:
#
#     default: &default
#       hue: 220
#
# You may also try other colors by setting params[:hue].
#
class Branding
  def initialize(params)
    @hue = params[:hue] || Rails.application.secrets[:hue] || 20
  end

  def color
    "hsl(#{@hue}, 97%, 43%)"
  end

  def background_color
    "hsl(#{@hue}, 10%, 96%)"
  end

  def cell_color
    'white'
  end
end
