# -*- coding: utf-8 -*-
module Capybara
  module Driver
    class Mechanize
      def put_content(url, content, env = {})
        begin
          if remote?(url)
            process_remote_request(:put, url, content, env)
          else
            register_local_request
            super
          end
        rescue ::Mechanize::ResponseCodeError => e
          @status_code = e.response_code.to_i
        else
          @status_code = 200
        end
      end

      def post_content(url, content, env = { })
        begin
          if remote?(url)
            process_remote_request(:post, url, content, env)
          else
            register_local_request
            super
          end
        rescue ::Mechanize::ResponseCodeError => e
          @status_code = e.response_code.to_i
        else
          @status_code = 200
        end
      end

      def post_json(url, json, params = { }, env = { })
        post_content(url, json.to_json, {  'Content-Type' => 'application/json; charset=utf-8' } )
      end

      # 正常に動作しないため、コメントアウト
      #def put_json(url, json, params = { }, env = { })
      #  put_content(url, json.to_json, {  'Content-Type' => 'application/json; charset=utf-8' } )
      #end

      def status_code
        @status_code
      end

      def get_with_status_code(*args, &block)
        begin
          get_without_status_code(*args, &block)
        rescue ::Mechanize::ResponseCodeError => e
          @status_code = e.response_code.to_i
        else
          @status_code = 200
        end
      end
      alias_method_chain :get, :status_code

      def visit_with_reset(url)
        visit_without_reset url
        remote = URI.parse(ENV['REMOTE_HOST'])
        @last_remote_host = "#{remote.scheme}://#{remote.host}:#{remote.port}"
      end
      alias_method_chain :visit, :reset

      # Capybara.app_host に指定した値にコンテキストルートが含まれる場合に
      # リモートサーバから取得したWebページから生成されるリクエストURLが正
      # しくない値になってしまう問題への対応パッチ
      # (例)
      # app_host: http://hostname/trunk/borabora
      # url:  /trunk/borabora/login/user
      #   生成される正しくないURL: http://hostname/trunk/borabora/trunk/borabora/login/user
      #   正しいURL: http://hostname/trunk/borabora/login/user
      def process_remote_request(method, url, *options)
        if remote?(url)

          #相対パス（../login/user）だと、RackTestではRoutingErorになるので、先頭の「..」を削除する
          url = url[2..url.size] if url =~ /^\.\./

          remote_uri = URI.parse(url)

          if remote_uri.host.nil?
            remote_host = @last_remote_host || Capybara.app_host || Capybara.default_host

            # urlにコンテキストルートが含まれる場合はそれを取り除く
            #   remote_host: http://hostname/trunk/bora
            #   url:  /trunk/bora/login/user
            #   => url: /login/user
            context_root = URI.parse(remote_host).path
            if context_root
              url.sub!(context_root, "")
            end

            url = File.join(remote_host, url)
            url = "http://#{url}" unless url.include?("http")
          else
            @last_remote_host = "#{remote_uri.host}:#{remote_uri.port}"
          end

          reset_cache
          @agent.send *( [method, url] + options)

          @last_request_remote = true
        end

        # for compatibility
        def parsed_body
        end
      end
    end
  end

  module Node
    module Actions
      def click_button_with_status_code(locator)
        begin
          click_button_without_status_code locator
        rescue ::Mechanize::ResponseCodeError => e
          @status_code = e.response_code.to_i
        else
          @status_code = 200
        end
      end
      alias_method_chain :click_button, :status_code
    end
  end
end

