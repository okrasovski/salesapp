class SalesController < ApplicationController

	before_filter do
	  @products = Product.ordered
	  @sources = Source.ordered
	    
	end

	def index
    @limit = (params[:limit].nil? ? Sale.last(20).count : (params[:limit]).to_i)
    @sales = Sale.top.first(@limit)

    respond_to do |format|
        format.html # index.html.erb
        
    end
  end

  def new
    @sale = Sale.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale }
    end
  end

  def create    

	  @sale = Sale.new(sale_params)                   
   
    respond_to do |format|
      if @sale.save & helpers.sale_dependencies(sale_params) 
        helpers.update_clients(params[:sale][:qrcode].tempfile, sale_params[:sale_sum]) if params[:sale][:qrcode].present?
        flash[:new_qrcode] = helpers.new_qrcode if params[:generate_qrcode].present?
        format.html { redirect_to :back, notice: "Sale was successfully made!"}        
        format.json { head :ok }
      else
        format.html { redirect_to :back, notice: "#{@sale.errors}"}
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :ok }
    end
  end
  
	private
		# Using a private method to encapsulate the permissible parameters is
    # just a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.

	  def sale_params sale_sum = 0
	  	
	  	params[:sale][:positions].each_pair{|name, amount| 
			  sale_sum +=  @products.find_by_name(name).price*amount.to_i}

	  	sale_params = params.require(:sale).permit(
	  		positions: params[:sale][:positions].try(:keys)).merge!({:sale_sum => sale_sum, 
	  		:timestamp => Time.now, :user => current_user.name})	
	    #return sale_params

	  end

end
