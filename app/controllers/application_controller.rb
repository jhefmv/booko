class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :page_not_found

  def page_not_found
    redirect_to root_path
  end
end
