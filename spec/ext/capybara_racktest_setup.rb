# -*- coding: utf-8 -*-
module Capybara
  module Driver
    class RackTest
      def post_json(path, json, params = {}, env = {})
        json = json.to_json unless json.is_a?(String)
        request_env = { 'CONTENT_LENGTH' => json.size,
          'CONTENT_TYPE' => 'application/json; charset=utf-8' ,
          'rack.input' => StringIO.new(json)
        }.merge(env)

        post(path, params, request_env)
      end

      def post_xml(path, xml, params = {}, env = {})
        request_env = { 'CONTENT_LENGTH' => xml.size,
          'CONTENT_TYPE' => 'application/xml; charset=utf-8' ,
          'rack.input' => StringIO.new(xml)
        }.merge(env)

        post(path, params, request_env)
      end


      def put_json(path, json, params = {}, env = {})
        json = json.to_json unless json.is_a?(String)
        request_env = { 'CONTENT_LENGTH' => json.size,
          'CONTENT_TYPE' => 'application/json; charset=utf-8' ,
          'rack.input' => StringIO.new(json)
        }.merge(env)

        put(path, params, request_env)
      end

      def put_xml(path, xml, params = {}, env = {})
        request_env = { 'CONTENT_LENGTH' => xml.size,
          'CONTENT_TYPE' => 'application/xml; charset=utf-8' ,
          'rack.input' => StringIO.new(xml)
        }.merge(env)

        put(path, params, request_env)
      end

      def parsed_body
        JSON.parse(body)
      end
    end
  end
end

module Rack
  module Test
    class Session
      def post(uri, params = {}, env = {}, &block)

        #相対パス（../login/user）だと、RackTestではRoutingErorになるので、先頭の「..」を削除する
        uri = uri[2..uri.size] if uri =~ /^\.\./

        env = env_for(uri, env.merge(:method => "POST", :params => params))
        process_request(uri, env, &block)
      end
    end
  end
end
