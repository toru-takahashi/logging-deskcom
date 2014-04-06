require_relative 'common.rb'

module Deskcom

class Cases < Common
  attr_reader :body, :total_entries, :next, :previous, :entries
  def initialize(data)
    @body = data
    @total_entries = data['total_entries'].to_i rescue 0
    @next = data['_links']['next']
    @previous = data['_links']['previous']
    @entries = data['_embedded']['entries']
  rescue => e
    STDERR.puts "Cases.initialize: #{e.message}"
  end
end

end