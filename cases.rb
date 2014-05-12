require_relative 'common.rb'

module Deskcom

class Cases < Common
  attr_reader :body, :total_entries, :next, :previous, :entries
  def initialize(data)
    super
    @body = data
    @total_entries = data['total_entries'].to_i rescue 0
    @entries = Array.new
    for i in 0..@total_entries.div(50) do
      data['_embedded']['entries'].each_with_index do |value, index|
        @entries << value
      end
      data = get("#{data['_links']['next']['href']}") unless data['_links']['next'].blank?
    end
  rescue => e
    STDERR.puts "Cases.initialize: #{e.message}"
  end
end

end