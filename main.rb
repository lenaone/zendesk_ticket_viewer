require 'sinatra' 
require 'sinatra/reloader'
require 'httparty'
require 'byebug'
require_relative 'models/ticket'



get '/tickets' do
  @tickets = Ticket.all
  erb :index
end

get '/tickets/:id' do 
  @id = params[:id]
  @ticket = Ticket.find(@id.to_i)
  erb :single_ticket
end






