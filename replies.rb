require_relative 'common.rb'
require_relative 'reply.rb'

module Deskcom

class Replies < Common
  attr_reader :total_entries, :next, :previous, :entries
  def initialize(data, caseid)
    @total_entries = data['total_entries'].to_i rescue 0
    
    @entries = Array.new

    reply_list = data['_embedded']['entries'] rescue Array.new
    if @total_entries > 0 then
      for i in 0..(@total_entries-1) do
        @entries << Reply.new(reply_list[i], caseid) rescue nil
      end
    end
  rescue => e
    STDERR.puts $@
    puts "replies.initialize: #{e.message}"
  end

end

end
