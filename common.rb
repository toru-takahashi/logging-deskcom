require 'rubygems'
require 'oauth'
require 'yaml'
require 'json'
require 'time'
require 'date'
require 'logger'
require 'active_support/core_ext'

module Deskcom

class Common
  def initialize(* args, & block)
    config = YAML.load_file('desk.config')

    @consumer = OAuth::Consumer.new(
      config['setting']['consumer_key'],
      config['setting']['consumer_secret'],
      :site => 'https://' + config['host'],
      :scheme => :header
    )

    @version = config['api_version']

    @access_token = OAuth::AccessToken.from_hash(
      @consumer,
      :oauth_token => config['setting']['access_token'],
      :oauth_token_secret => config['setting']['access_token_secret']
    )
  rescue => e
    STDERR.puts "common.ini: #{e.message}"
  end

  def get(path, cnt_retry=0)
    response = @access_token.get(path)
    JSON.load(response.body) if response.code == '200'
  rescue => e
    cnt_retry += 1
    retry if cnt_retry < 5
    STDERR.puts "common.get: #{e.message}"
  end
end

end
