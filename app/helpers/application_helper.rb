# frozen_string_literal: true

module ApplicationHelper
  def branding_css(branding)
    render 'layouts/branding.html.erb', branding: branding
  end
end
