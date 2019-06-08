# frozen_string_literal: true

require 'httparty'

class Ticket
  attr_accessor :id, :subject, :status

  TICKET_API_URL = 'https://zenlena.zendesk.com/api/v2/tickets.json'
  AUTH = { username: 'sulyh9@gmail.com', password: 'zendesk' }.freeze

  def initialize(ticket_hash)
    @id = ticket_hash['id']
    @subject = ticket_hash['subject']
    @status = ticket_hash['status']
  end

  # fetch tickets with api, send data as hash
  def self.fetch_tickets(page: 1, per_page: 25)
    response = HTTParty.get("#{TICKET_API_URL}?page=#{page}&per_page=#{per_page}", basic_auth: AUTH)
    if response.code == 404 || response.code == 401
      { 'tickets' => [], 'total' => 0, 'error_message' => response['error'] }
    else
      tickets = response['tickets'].map do |ticket|
        Ticket.new(ticket)
      end
      {
        'tickets' => tickets,
        'total' => response['count']
      }
    end
  end

  # generate all tickets
  def self.all
    page = 1
    response = fetch_tickets(page: page, per_page: 100)
    count = response['total']
    tickets = response['tickets']
    while count > tickets.count
      page += 1
      tickets << fetch_tickets(page: page, per_page: 100)['tickets']
    end
    tickets.flatten
  end

  # generate a ticket
  def self.find(number)
    all.find { |each_ticket| each_ticket.id == number }
  end
end
