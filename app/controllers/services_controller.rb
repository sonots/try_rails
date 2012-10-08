class ServicesController < ApplicationController
  def index
    render :status => 200, :json => {"text" => "hello world"}
  end
end
