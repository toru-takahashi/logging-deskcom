require_relative 'common.rb'
require_relative 'replies.rb'
require_relative 'reply.rb'

module Deskcom

class Case < Common
  attr_reader :id, :external_id, :blurb, :subject, :status, :type, :language, :created_at, :updated_at, :active_at, :received_at, :first_opened_at, :opened_at, :first_resolved_at, :resolved_at, :custom_fields, :message, :history, :replies

  def initialize(data)
    super
    @id                = data['id']
    @external_id       = data['external_id']
    @blurb             = data['blurb']
    @subject           = data['subject']
    @status            = data['status']
    @type              = data['type']
    @language          = data['language']
    @created_at        = data['created_at'].nil?        ? nil : Time.parse(data['created_at'])
    @updated_at        = data['updated_at'].nil?        ? nil : Time.parse(data['updated_at'])
    @active_at         = data['active_at'].nil?         ? nil : Time.parse(data['active_at'])
    @received_at       = data['received_at'].nil?       ? nil : Time.parse(data['received_at'])
    @first_opened_at   = data['first_opened_at'].nil?   ? nil : Time.parse(data['first_opened_at'])
    @opened_at         = data['opened_at'].nil?         ? nil : Time.parse(data['opened_at'])
    @first_resolved_at = data['first_resolved_at'].nil? ? nil : Time.parse(data['first_resolved_at'])
    @resolved_at       = data['resolved_at'].nil?       ? nil : Time.parse(data['resolved_at'])
    @custom_fields     = data['custom_fields']

    #@message  = data['_links']['message']['href'].nil? ? nil : get(data['_links']['message']['href'])
    #@history  = data['_links']['history']['href'].nil? ? nil : get(data['_links']['history']['href'])
    @replies = Replies.new( get("#{data['_links']['replies']['href']}" ) )
  end

  def reply(reply_id)
    Reply.new( get("/api/#{@version}/cases/#{@id.to_i}/replies/#{reply_id.to_i}") )
  end

end

end