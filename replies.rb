require_relative 'common.rb'

module Deskcom

class Replies < Common
  attr_reader :total_entries, :next, :previous, :entries
  def initialize(data)
    @total_entries = data['total_entries'].to_i
    #@next     = data['_links']['next'].nil?       ? nil : data['_links']['next']
    #@previous = data['_links']['previous'].nil?   ? nil : data['_links']['previous']
   # @entries  = data['_embedded']['entries'].nil? ? nil : data['_embedded']['entries']
  end
end

end