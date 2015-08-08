module ApplicationHelper
  def branding_css(branding)
    render 'layouts/branding.html.erb', branding: branding
  end
end
