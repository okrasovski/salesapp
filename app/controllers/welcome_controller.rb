class WelcomeController < ApplicationController

	before_filter do
    @products = Product.ordered
    @sources = Source.ordered
    @sales = Sale.top.first(20)
    
  end

	def index
		respond_to do |format|
		  format.html # index.html.erb
		  #format.json {}
		end
	end 

end
