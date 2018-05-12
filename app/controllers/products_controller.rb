class ProductsController < ApplicationController
	
	before_filter do
	    @products = Product.ordered
      @sources = Source.ordered 
	end

  def index
    @products = Product.ordered  

    respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @products}
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end
p
  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
     #params.permit![:sources].to_h[:sources]
    respond_to do |format|
    	@product.sources = params["sources"]
      if @product.update!(product_params) #.merge!({"sources" => params["sources"]}))
        format.html { redirect_to :back, notice: "Product was successfully updated." }
        format.json { head :ok }
      else
        format.html { redirect_to :back }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  #{"utf8"=>"✓", "_method"=>"put", "sources"=>{"coffee"=>"20", "milk"=>"140"}, "id"=>"1"}

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

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
    def product_params

    	params.require(:product).permit(:name, :price, 
        sources: params[:product][:sources].try(:keys))
    	#product_params[:sources] = params["sources"]

    end
  
end
