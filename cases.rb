require_relative 'common.rb'
require_relative 'replies.rb'
module Deskcom

class Cases < Common
  attr_reader :body, :list
  def initialize
    super
    @body = get("/cases")
    @cases = Hash.new
  end

  def show(id=nil)
    return @body if id.nil?
    @list["#{id}"] = @list.has_key?("#{id}") ? @list["#{id}"] : Case.new( get("/cases/#{id}") )
  end

  def refresh(id=nil)
  end

  def count
    @body["total_entries"].to_i
  end
end

class Case
  attr_reader :id, :blurb, :subject, :body, :status, :type, :language, :created_at, :updated_at, :active_at, :received_at,
              :first_opened_at, :opened_at, :first_resolved_at, :resolved_at, :custom_fields

  def initialize(body)
    @body              = body
    @id                = body["id"]
    @blurb             = body["blurb"]
    @subject           = body["subject"]
    @status            = body["status"]
    @type              = body["type"]
    @language          = body["language"]
    @created_at        = body["created_at"].nil?        ? nil : Time.parse(body["created_at"])
    @updated_at        = body["updated_at"].nil?        ? nil : Time.parse(body["updated_at"])
    @active_at         = body["active_at"].nil?         ? nil : Time.parse(body["active_at"])
    @received_at       = body["received_at"].nil?       ? nil : Time.parse(body["received_at"])
    @first_opened_at   = body["first_opened_at"].nil?   ? nil : Time.parse(body["first_opened_at"])
    @opened_at         = body["opened_at"].nil?         ? nil : Time.parse(body["opened_at"])
    @first_resolved_at = body["first_resolved_at"].nil? ? nil : Time.parse(body["first_resolved_at"])
    @resolved_at       = body["resolved_at"].nil?       ? nil : Time.parse(body["resolved_at"])
    @custom_fields     = body["custom_fields"]

    @replies = nil
  end

  def replies
    @replies || Replies.new("#{@id}")
  end
end

end