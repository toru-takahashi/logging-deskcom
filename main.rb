require_relative 'desk.rb'
require 'td'

#TDへの接続情報
TreasureData::Logger.open_agent('td.support',
:auto_create_table=>true)

desk = Deskcom::Desk.new

for i in 1..desk.cases.total_entries do
  replies = desk.replies(i)
  p i
  for j in 0..(replies.total_entries-1) do
    p "#{i}.#{j}"
    TD.event.post('deskreply', replies.entries[j].tojson)
  end  
  sleep(1)
end
