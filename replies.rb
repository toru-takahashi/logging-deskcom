require_relative 'common.rb'

module Deskcom

class Replies < Common
  attr_reader :case_id, :replies, :body
  def initialize(case_id)
    super
    @case_id = case_id
    @body = get("/cases/#{@case_id}/replies")
    @replies = Hash.new
    puts @body
  end

  def show(id=nil)
    return @body if id.nil?
    @replies["#{id}"] = @replies.has_key?("#{id}") ? replies[:id] : Reply.new(get("/cases/#{@case_id}/replies/#{id}") )
  end

  def count
    @body["total_entries"].to_i
  end
end

class Reply
  attr_reader :subject, :body, :status, :to, :from, :cc, :bcc, :created_at, :updated_at
  def initialize(body)
    @subject = body["subject"]
    @message = body["body"]
    @status = body["status"]
    @to = body["to"]
    @from = body["from"]
    @cc = body["cc"]
    @bcc = body["bcc"]
    @created_at = body["created_at"].nil? ? nil : Time.parse(body["created_at"])
    @updated_at = body["updated_at"].nil? ? nil : Time.parse(body["updated_at"])
  end
end

end