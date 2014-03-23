require 'rubygems'
require 'oauth'
require 'yaml'
require 'json'
require 'time'

module Deskcom
  class Common
    def initialize(* args, & block)
      config = YAML.load_file('desk.config')
      @consumer = OAuth::Consumer.new(
        config['setting']['consumer_key'],
        config['setting']['consumer_secret'],
        :site => 'https://' + config['host'] + '/api/' + config['api_version'],
        :scheme => :header
      )
      @access_token = OAuth::AccessToken.from_hash(
        @consumer,
        :oauth_token => config['setting']['access_token'],
        :oauth_token_secret => config['setting']['access_token_secret']
      )
    end

    def get(path)
      begin
        response = @access_token.get(path)
        if response.code == '200'
          return JSON.load(response.body)
        else
          puts response.code
          return nil
        end
      rescue => ex
        puts ex.message
        return nil
      end
    end
  end
end