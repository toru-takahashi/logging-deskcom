require_relative 'common.rb'

module Deskcom

class Reply < Common
  attr_reader :subject, :body, :status, :direction, :to, :from, :cc, :bcc, :created_at, :updated_at
  def initialize(data)
    @subject    = data['subject']
    @body       = data['body']
    @status     = data['status']
    @direction  = data['direction']
    @to         = data['to']
    @from       = data['from']
    @cc         = data['cc']
    @bcc        = data['bcc']
    @created_at = data['created_at'].nil? ? nil : Time.parse(data['created_at'])
    @updated_at = data['updated_at'].nil? ? nil : Time.parse(data['updated_at'])
  end
end

end
