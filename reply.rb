require_relative 'common.rb'

module Deskcom

class Reply < Common
  attr_reader :subject, :body, :status, :direction, :to, :from, :cc, :bcc, :client_type, :created_at, :updated_at, :uri, :case, :customer, :caseid
  def initialize(data, caseid)
    @caseid      = caseid
    @subject     = data['subject']
    @body        = data['body']
    @status      = data['status']
    @direction   = data['direction']
    @to          = data['to']
    @from        = data['from']
    @cc          = data['cc']
    @bcc         = data['bcc']
    @client_type = data['client_type']
    @created_at  = DateTime.strptime(data['created_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @updated_at  = DateTime.strptime(data['updated_at'],'%Y-%m-%dT%H:%M:%SZ').strftime('%s').to_i rescue 0
    @uri         = data['_links']['self']['href'] rescue nil
    @case        = data['_links']['case']['href'] rescue nil
    @customer    = data['_links']['customer']['href'] rescue nil
  rescue => e
    STDERR.puts $@
    STDERR.puts "Reply.initialize: #{e.message}"
  end

  def tojson
    {
      'caseid' => @caseid,
      'subject' => @subject,
      'body' => @body,
      'status' => @status,
      'direction' => @direction,
      'to' => @to,
      'from' => @from,
      'cc' => @cc,
      'bcc' => @bcc,
      'client_type' => @client_type,
      'created_at' => @created_at,
      'updated_at' => @updated_at,
      'self' => @uri,
      'case' => @case,
      'customer' => @customer,
      'time' => @created_at
    }
  end

end

end
