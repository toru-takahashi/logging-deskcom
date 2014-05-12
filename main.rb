require_relative 'desk.rb'
require 'td'

#connection to TD
TreasureData::Logger.open_agent('td.support', :auto_create_table=>true)


def load()
  config = YAML.load_file('desk.config')
  last_measurement_time = config['last_measurement_time']
end
def save(last_measurement_time)
  config = YAML.load_file('desk.config')
  config['last_measurement_time'] = last_measurement_time
  YAML.dump(config)
end

#for i in 1..2000 do
#  TD.event.post('testjson', {"time"=>1396855702,"data"=>{"test2"=>"#{i-1}","test1"=>i}})
#end
last_measurement_time = load()

desk = Deskcom::Desk.new
begin
  cases = desk.case_search(last_measurement_time)
  for i in 0..cases.total_entries-1 do
    TD.event.post('deskcase', cases.entries[i].tojson)
    replies = desk.replies(cases.entries[i]['id'])
    for j in 0..(replies.total_entries-1) do
      TD.event.post('deskreply', replies.entries[j].tojson) if replies.entries[j].created_at > last_measurement_time
    end
  end
rescue Exception => e
  STDERR.puts "main.initialize: #{e.message}"
end

save(Time.now.to_i - 300)

#