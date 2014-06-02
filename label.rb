require_relative 'common.rb'
require_relative 'lables.rb'

module Deskcom

class Label < Common
  attr_reader :id, :name, :description

  def initialize(data)
    @id           = data['id']
    @name         = data['name']
    @description  = data['description']
  rescue =>e
    STDERR.puts $@
    STDERR.puts "Label.initialize: #{e.message}"
  end

  def tojson
    {
        'id'          => @id,
        'name'        => @name,
        'description' => @description
    }
  end
  
end

end