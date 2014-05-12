require_relative 'common.rb'
require_relative 'reply.rb'

module Deskcom

class Replies < Common
  attr_reader :total_entries, :next, :previous, :entries
  def initialize(data, caseid)
    @total_entries = data['total_entries'].to_i rescue 0
    
    #@next     = data['_links']['next'].nil?       ? nil : data['_links']['next']
    #@previous = data['_links']['previous'].nil?   ? nil : data['_links']['previous']
    @entries = Array.new

    reply_list = data['_embedded']['entries']
    
    for i in 0..(@total_entries-1) do
      @entries << Reply.new(reply_list[i], caseid)
    end
  rescue => e
    puts "replis.initialize: #{e.message}"
  end

end

end
