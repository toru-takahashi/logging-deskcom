require_relative 'desk.rb'
require 'td'

#connection to TD
TreasureData::Logger.open_agent('td.support', :auto_create_table=>true)

def load()
  config = YAML.load_file('desk.config')
  last_measurement_time = config['last_measurement_time']
rescue Exception => e
  STDERR.puts $@
  STDERR.puts "load: #{e.message}"
end

def save(last_measurement_time)
  config = YAML.load_file('desk.config')
  config['last_measurement_time'] = last_measurement_time
  open("desk.config","w") do |f|
    YAML.dump(config,f)
  end
rescue Exception => e
  STDERR.puts $@
  STDERR.puts "save: #{e.message}"
end

last_measurement_time = load()

desk = Deskcom::Desk.new
begin
  cases = desk.case_search(last_measurement_time)
  if cases.total_entries > 0 then
    p "cases total_entries: #{cases.total_entries}"
    for i in 0..cases.total_entries-1 do
      next if i < 2490
      p "cases: #{i}"
      deskcase = desk.case(cases.entries[i]['id'])

      TD.event.post('deskcase', deskcase.tojson)

      sleep(1)

      replies = desk.replies(cases.entries[i]['id'])

      if replies.total_entries > 0 then
        p "repliy total: #{reply_list.total_entries}"
        for j in 0..replies.total_entries-1 do
          p "reply: #{j}"
          reply = desk.reply("#{replies.entries['_links']['self']['href']}", cases.entries[i]['id'])
          TD.event.post('deskreply', reply.tojson) if reply.created_at > last_measurement_time
          sleep(1)
        end
      end
    end
  end
  save(Time.now.to_i)
rescue Exception => e
  STDERR.puts $@
  STDERR.puts "main.initialize: #{e.message}"
end
