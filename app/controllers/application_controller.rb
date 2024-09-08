class ApplicationController < ActionController::Base
  def page_not_found
    redirect_to root_path
  end
end
