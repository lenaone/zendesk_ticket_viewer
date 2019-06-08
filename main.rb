# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require_relative 'models/ticket'

get '/' do
  redirect '/tickets'
end

get '/tickets' do
  tickets = Ticket.fetch_tickets(page: params[:page])
  @tickets = tickets['tickets']
  @total = tickets['total']
  @error = tickets['error_message']

  @first_page = 1
  @range = 25
  @last_page = @total / @range + 1 if @total % @range != 0
  @current_page = params[:page].nil? ? @first_page : params[:page].to_i
  @previous_page = @current_page - 1 if @current_page != @first_page
  @next_page = @current_page + 1 if @current_page != @last_page
  erb :tickets
end

get '/tickets/:id' do
  @id = params[:id]
  @ticket = Ticket.find(@id.to_i)
  return status 404 if @ticket.nil?

  @range = 25
  @first_page = 1
  @total = Ticket.fetch_tickets(page: params[:page])['total']
  @last_page = @total / @range + 1 if @total % @range != 0
  @page_hash = (@first_page..@last_page).each_with_object({}) do |page_number, hash|
    tickets = Ticket.fetch_tickets(page: page_number, per_page: 25)
    hash[page_number] = tickets['tickets'].map(&:id)
  end
  value = @page_hash.values.select { |number| number.include?(@id.to_i) }.first
  @page = @page_hash.key(value)
  erb :single_ticket
end
