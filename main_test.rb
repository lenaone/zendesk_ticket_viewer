# frozen_string_literal: true

require 'minitest/autorun'
require 'rack/test'
require 'minitest/unit'
require 'mocha/minitest'
require_relative 'main'

class TicketTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_tickets_request
    get '/tickets'
    assert last_response.ok?
  end

  def test_tickets_not_found_request_404
    fake_response = mock('fake api response')
    fake_response.expects(:code).returns(404).at_least_once
    fake_response.expects('[]').with('error').returns("The server can't find").at_least_once
    HTTParty.expects(:get).returns(fake_response)
    get '/tickets'
    assert last_response.ok?
  end

  def test_tickets_unauthorized_request_401
    fake_response = mock('fake response')
    fake_response.expects(:code).returns(401).at_least_once
    fake_response.expects('[]').with('error').returns("It's not authorized").at_least_once
    HTTParty.expects(:get).returns(fake_response)
    get '/tickets'
    assert last_response.ok?
  end

  def test_invalid_ticket_id
    Ticket.expects(:find).with(123).returns(nil)
    get '/tickets/123'
    assert last_response.not_found?
  end

  def test_valid_ticket_id
    Ticket.expects(:find).with(234).returns(Ticket.new(id: '234', subject: 'fake subject', status: 'fake open'))
    get '/tickets/234'
    assert last_response.ok?
  end
end
