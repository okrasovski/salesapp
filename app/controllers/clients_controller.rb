class ClientsController < ApplicationController


	def index
		@clients = Client.top
		
		respond_to do |format|
		  format.html # index.html.erb
		  #format.json {}
		end
	end 



end
