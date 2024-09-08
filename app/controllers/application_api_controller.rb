class ApplicationApiController < ActionController::API
  rescue_from StandardError do |standard_error|
    Rails.logger.info standard_error.to_s
    Rails.logger.info standard_error.backtrace.join("\n")
    render_with_json_error(BookoApiError.new(BookoApiError::INTERNAL_SERVER_ERROR))
  end

  rescue_from ActionController::ParameterMissing, with: :missing_required_params_error

  def missing_required_params_error
    render_with_json_error(BookoApiError.new(BookoApiError::MISSING_REQUIRED_PARAMS))
  end

  def render_with_json_error(error)
    render json: error.to_json, status: error.http_status
  end
end
