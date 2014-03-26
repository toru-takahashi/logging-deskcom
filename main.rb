require_relative 'desk.rb'

desk = Deskcom::Desk.new

desk_case = desk.case(2767)

if desk_case.replies.nil?
  puts "no reply"
  return
end

puts desk_case.replies.total_entries.to_i

for i in 1..desk_case.replies.total_entries.to_i
  reply = desk_case.reply(i)
  puts reply.subject
  puts reply.body
end