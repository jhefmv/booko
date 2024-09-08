class BookoApiError < StandardError
  attr_reader :code, :http_status, :message

  # Error Constants
  MISSING_REQUIRED_PARAMS = ["Missing required parameter", :bad_request, 400]
  INTERNAL_SERVER_ERROR = ["Internal error", :internal_server_error, 5003]

  def initialize(error_type)
    @message, @http_status, @code = *error_type
    @http_status = Rack::Utils.status_code(@http_status)
    super(@message)
  end
end
