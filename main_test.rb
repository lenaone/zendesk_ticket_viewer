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

  def test_tickets_unauthorized_api_request_404
    fake_response = mock('fake unathorized api response')
    fake_response.expects(:code).returns(404).at_least_once
    fake_response.expects('[]').with('error').returns("The server can't find ").at_least_once
    HTTParty.expects(:get).returns(fake_response)
    get '/tickets'
    assert last_response.ok?
  end

  def test_tickets_unauthorized_request_401
    fake_response = mock('hi')
    fake_response.expects(:code).returns(401).at_least_once
    fake_response.expects('[]').with('error').returns("It's not authorized").at_least_once
    HTTParty.expects(:get).returns(fake_response)
    get '/tickets'
    assert last_response.ok?
  end

  def test_invalid_ticket_id_returns
    Ticket.expects(:find).with(123).returns(nil)
    get '/tickets/123'
    assert last_response.not_found?
  end

  def test_valid_ticket_id
    Ticket.expects(:find).with(234).returns(Ticket.new({ :id => '234', :subject => 'fake subject' }))
    get '/tickets/234'
    assert last_response.ok?
  end

  def test_valid_ticket_id_with_api
    get '/tickets/23'
    assert last_response.ok?
  end

  def test_invalid_ticket_id_with_api
    get '/tickets/345'
    assert last_response.not_found?
  end

  def test_with_all_tickets
    ticket = Ticket.all
    last_id = ticket.map(&:id).last
    assert_equal last_id, Ticket.all.count
  end

end