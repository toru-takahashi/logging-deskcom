
require 'rubygems'
require 'oauth'
require 'yaml'
require 'json'


config = YAML.load_file('config.yml')
consumer = OAuth::Consumer.new(
  config['setting']['consumer_key'],
  config['setting']['consumer_secret'],
  :site => 'https://' + config['host'],
  :scheme => :header
)
@access_token = OAuth::AccessToken.from_hash(
  consumer,
  :oauth_token => config['setting']['access_token'],
  :oauth_token_secret => config['setting']['access_token_secret']
)

class Case
  def initialize(ver='v2', id=nil)
    @ver = ver
    @id = id
  end
  def show
    response = @access_token.get('/api/' + @ver + '/cases/' + id)
    JSON.load(response.body)
  end
  def list
    response = @access_token.get('/api/'+ @ver +'/cases')
    JSON.load(response.body)
  end

  def search
  end
end


#case_h = getCase(i.to_s)
#puts case_h

#article_h = getArticle(i.to_s)
#puts article_h
#cases = list()
#puts cases["total_entries"]
response = @access_token.get('/api/v2/cases/search?since_updated_at=1395251700')
puts JSON.pretty_generate(JSON.load(response.body))