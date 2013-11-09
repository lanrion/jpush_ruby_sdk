require "rest-client"

module JpushRubySdk
  class Client
    include ApiHelper

    attr_accessor :app_key, :master_secret

    def initialize(app_key, master_secret, opts={}, &block)
      @app_key       = app_key
      @master_secret = master_secret
    end

    # HTTP

    # 推送全功能接口
    # url: http://docs.jpush.cn/display/dev/Send+API+v2#SendAPIv2-推送全功能接口
    # api:  sendmsg/v2/sendmsg
    # options: send_description, time_to_live, override_msg_id
    def push_notification(sendno, receiver, msg, https=false, options={})
      # default: HTTP
      api_url = https == true ? HTTPS_JPUSH_API_URL_NOTIFICATION : HTTP_JPUSH_API_URL

      post_body = {}
      post_body[:app_key] = app_key
      post_body[:sendno]  = sendno
      post_body[:receiver_type]     = receiver[:receiver_type]
      post_body[:receiver_value]    = receiver[:receiver_value]
      post_body[:verification_code] = build_verifcation(sendno,
                                                       receiver[:receiver_type],
                                                       receiver[:receiver_value],
                                                       master_secret)
      post_body[:msg_type]    = msg[:msg_type]
      post_body[:msg_content] = msg[:msg_content]
      post_body[:platform]    = msg[:platform]
      post_body.merge!(options)

      post_jpush_api(api_url, post_body)
    end

    private

      # MD5 secret
      def build_verifcation(sendno, receiver_type, receiver_value, master_secret)
        verifcation = "#{sendno}#{receiver_type}#{receiver_value}#{master_secret}"
        Digest::MD5.hexdigest(verifcation)
      end

      # format response data
      def hashie(response)
        json_body = MultiJson.load(response.body)
        if json_body.is_a? Array
          Array.new(json_body.count){|i| Hashie::Mash.new(json_body[i])}
        else
          Hashie::Mash.new json_body
        end
      end

      # post jpush api
      def post_jpush_api(api_url,post_body)
        response_msg = RestClient.post(
          api_url,
          post_body,
          content_type: "application/x-www-form-urlencoded",
          accept: :json)
        hashie(response_msg)

      end
  end
end