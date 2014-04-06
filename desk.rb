require_relative 'common.rb'
require_relative 'cases.rb'
require_relative 'case.rb'

module Deskcom

class Desk < Common
  def initialize()
    super
  end

  def cases
    Cases.new( get("/api/#{@version}/cases") )
  end

  def case(id=nil)
    Case.new( get("/api/#{@version}/cases/#{id}") ) unless id.nil?
  end

  def replies(id=nil)
    Replies.new( get("/api/#{@version}/cases/#{id}/replies"), id) unless id.nil?
  end
end

end