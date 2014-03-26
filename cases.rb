require_relative 'common.rb'

module Deskcom

class Cases < Common
  attr_reader :total_entries, :next, :previous, :entries
  def initialize(data)
    @total_entries = data['total_entries'].to_i
    @next = data['_links']['next']
    @previous = data['_links']['previous']
    @entries = data['_embedded']['entries']
  end

end

end