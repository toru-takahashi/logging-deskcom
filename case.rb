require_relative 'common.rb'
require_relative 'replies.rb'
require_relative 'reply.rb'

module Deskcom

class Case < Common
  attr_reader :id, :external_id, :blurb, :subject, :priority, :status, :type, :label_ids, :language, :created_at, :updated_at, :active_at, :received_at, :first_opened_at, :opened_at, :first_resolved_at, :resolved_at, :custom_fields, :message, :history, :replies, :assigned_group, :uri, :customer

  def initialize(data)
    super
    @id                = data['id']
    @external_id       = data['external_id']
    @blurb             = data['blurb']
    @subject           = data['subject']
    @priority          = data['priority'].to_i rescue 0
    @status            = data['status']
    @type              = data['type']
    @label_ids         = data['label_ids']
    @language          = data['language']
    @created_at        = DateTime.strptime(data['created_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @updated_at        = DateTime.strptime(data['updated_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @active_at         = DateTime.strptime(data['active_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @received_at       = DateTime.strptime(data['received_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @first_opened_at   = DateTime.strptime(data['first_opened_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @opened_at         = DateTime.strptime(data['opened_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @first_resolved_at = DateTime.strptime(data['first_resolved_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @resolved_at       = DateTime.strptime(data['resolved_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @custom_fields     = data['custom_fields']['_type']

    @uri            = data['_links']['self']['href']
    @customer       = data['_links']['customer']['href']
    @assigned_group = data['_links']['assigned_group']['href']
    @message        = data['_links']['message']['href']
    @history        = data['_links']['history']['href']
    
    @replies        = data['_links']['replies']['href']
    #@replies  = Replies.new( get(data['_links']['replies']['href'] ) )

  rescue =>e
    STDERR.puts "Case.initialize: #{e.message}"
  end

  def reply(reply_id)
    @replies.entries[reply_id]
    #Reply.new( get("/api/#{@version}/cases/#{@id}/replies/#{reply_id}") ) unless reply.nll?
  rescue => e
    STDERR.puts "Case.reply: #{e.message}"
  end

  def tojson
    {
        'id'          => @id,
        'external_id' => @external_id,
        'blurb'       => @blurb,
        'subject'     => @subject,
        'priority'    => @priority,
        'status'      => @status,
        'type'        => @type,
        'label_ids'   => @label_ids,
        'language'    => @language,
        'created_at'  => @created_at,
        'updated_at'  => @updated_at,
        'active_at'   => @active_at,
        'received_at' => @received_at,
        'first_opened_at' => @first_opened_at,
        'opened_at'   => @opened_at,
        'first_resolved_at' => @first_resolved_at,
        'resolved_at' => @resolved_at,
        'custom_fields' => @custom_fields,
        'message'     => @message,
        'history'     => @history,
        'replies'     => @replies,
        'assigned_group' => @assigned_group,
        'self'        => @uri,
        'customer'    => @customer,
        'time'        => @created_at
    }
  end
  
end

end