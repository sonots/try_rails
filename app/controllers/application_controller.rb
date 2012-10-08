class NotFound < Exception
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_error(status, options = {})
    json = {}
    json[:inquiry_code] = options[:inquiry_code] if options[:inquiry_code]
    json[:errors] = options[:errors].map {|e| { :message_id => e } } if options[:errors]
    render :status => status, :json => json
  end

  rescue_from NotFound do |e|
    render_error 404
  end
end
