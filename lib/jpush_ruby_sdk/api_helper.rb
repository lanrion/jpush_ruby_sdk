require 'hashie'

module JpushRubySdk
  module ApiHelper
    HTTP_BASE_URL = "http://api.jpush.cn:8800"
    HTTPS_BASE_URL =  "https://api.jpush.cn:443"

    # HTTP
    HTTP_JPUSH_API_URL = "#{HTTP_BASE_URL}/sendmsg/v2/sendmsg"
    HTTP_JPUSH_API_URL_NOTIFICATION = "#{HTTP_BASE_URL}/sendmsg/v2/notification"
    HTTP_JPUSH_API_URL_CUSTOM_MESSAGE = "#{HTTP_BASE_URL}/sendmsg/v2/custom_message"

    # HTTPS
    HTTPS_JPUSH_API_URL = "#{HTTPS_BASE_URL}/sendmsg/v2/sendmsg"
    HTTPS_JPUSH_API_URL_NOTIFICATION = "#{HTTPS_BASE_URL}/sendmsg/v2/notification"
    HTTPS_JPUSH_API_URL_CUSTOM_MESSAGE = "#{HTTPS_BASE_URL}/sendmsg/v2/custom_message"
  end
end