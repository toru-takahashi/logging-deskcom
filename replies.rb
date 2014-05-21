require_relative 'common.rb'
require_relative 'reply.rb'

module Deskcom

class Replies < Common
  attr_reader :total_entries, :entries
  def initialize(data, caseid)
    @total_entries = data['total_entries'].to_i rescue 0
    @entries = Array.new

    for i in 0..@total_entries.div(50) do
      data['_embedded']['entries'].each_with_index do |value, index|
        @entries << value
      end
      data = get("#{data['_links']['next']['href']}") rescue nil
    end
  rescue => e
    STDERR.puts $@
    puts "replies.initialize: #{e.message}"
  end

end

end
