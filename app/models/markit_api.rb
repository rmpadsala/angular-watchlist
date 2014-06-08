class MarkitApi

  def self.get_response(attributes={})
    method = attributes[:method]
    query_params = attributes[:query_params]

    # full_uri = "http://dev.markitondemand.com/Api/v2/Quote/json?symbol=AAPL"
    full_uri = "http://dev.markitondemand.com/Api/v2/#{method}/json?#{query_params}"
    Rails.logger.debug("Request URL: #{full_uri}")

    content_type = attributes[:content_type] ||= :json
    accept_type = attributes[:accept] ||= :json

    begin
      response = nil
      if attributes[:request_type] == 'GET'
        response = RestClient.get full_uri, {
          accept: accept_type
        }
      end

      json_response = JSON.parse response;

      if json_response["Status"] == "SUCCESS"
        hash = {
          success: true,
          response: json_response
        }
      else
        hash = {
          success: false,
          response: json_response
        }
      end

    rescue RestClient::Exception => e
      Rails.logger.error("HTTP Code: #{e.http_code}, Message: #{e.message}, backtrace: #{e.backtrace.join("\n")}")
      hash = {
        status: e.http_code,
        success: false,
        message: "#{attributes[:request_type]}::RestClient exception occurred while in get_response_and_add_header request, message: #{e.message}"
      }
    rescue Exception => e
      Rails.logger.error("Message: #{e.message}, backtrace: #{e.backtrace.join("\n")}")
      hash = {
        status: 500,
        success: false,
        message: "#{attributes[:request_type]}::Exception occurred while in get_response_and_add_header, message: #{e.message}"
      }
    end
    hash
  end
end
