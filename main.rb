require_relative 'common.rb'
require_relative 'cases.rb'

cases = Deskcom::Cases.new

c = cases.show()

puts c.show

replies = c.replies

puts replies.show




#desk.cases.get()
#desk.cases
#desk.cases.replies.get()
#desk.cases.replies

#case_h = getCase(i.to_s)
#puts case_h

#article_h = getArticle(i.to_s)
#puts article_h
#cases = list()
#puts cases["total_entries"]
#response = @access_token.get('/api/v2/cases/search?since_updated_at=1395251700')
#puts JSON.pretty_generate(JSON.load(response.body))