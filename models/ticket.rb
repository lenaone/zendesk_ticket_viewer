require 'httparty'
require 'byebug'

class Ticket

  attr_accessor :id, :subject

  TICKET_API_URL = "https://zenlena.zendesk.com/api/v2/tickets.json"
  AUTH = { :username => 'sulyh9@gmail.com', :password => 'zendesk' }

  def initialize(ticket_hash)
    @id = ticket_hash["id"]
    @subject = ticket_hash["subject"]
  end

  # fetch tickets with api, send data as hash
  def self.fetch_tickets(page: 1, per_page: 25)
    response = HTTParty.get("#{TICKET_API_URL}?page=#{page}&per_page=#{per_page}", :basic_auth => AUTH)
    tickets = response["tickets"].map do |ticket|
      Ticket.new(ticket)
    end
    {
      "tickets" => tickets,
      "total" => response["count"]
    }
  end
  
  # generate all tickets
  def self.all
    page = 1
    response = fetch_tickets(page: page, per_page: 100)
    count = response["total"]
    tickets = response["tickets"]

    while count > tickets.count do
      page += 1
      tickets << fetch_tickets(page: page, per_page: 100)["tickets"]
    end
    tickets.flatten

  end

  # generate a ticket
  def self.find(number)
    
    all.find {|each_ticket| each_ticket.id == number }
  end

end