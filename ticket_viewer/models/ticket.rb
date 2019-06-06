require 'httparty'
require 'byebug'

class Ticket

  attr_accessor :id, :subject

  TICKET_API_URL = "https://zenlena.zendesk.com/api/v2/tickets.json"

  def initialize(ticket_hash)
    @id = ticket_hash["id"]
    @subject = ticket_hash["subject"]
  end
  
  # generate all tickets
  def self.all
    auth = { :username => 'sulyh9@gmail.com', :password => 'zendesk' }
    response = HTTParty.get(TICKET_API_URL, :basic_auth => auth)
    @tickets = response["tickets"]
    @tickets.map do |ticket|
      Ticket.new(ticket)
    end
  end

  # generate a ticket
  def self.find(number)
    all.find {|each_ticket| each_ticket.id == number }
  end

end