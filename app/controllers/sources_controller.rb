class SourcesController < ApplicationController
	before_filter do
	    @sources = Source.ordered
	end

  def index
    @sources = Source.ordered  

    respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @sources}
    end
  end

  # GET /sources/new
  # GET /sources/new.json
  def new
    @source = Source.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chain }
    end
  end

  # GET /sources/1/edit
  def edit
    @source = Source.find(params[:id])
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Source.new(params[:source])

    respond_to do |format|
      if @source.save
        format.html { redirect_to @source, notice: 'Source was successfully created.' }
        format.json { render json: @source, status: :created, location: @source }
      else
        format.html { render action: "new" }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sources/1
  # PUT /sources/1.json
  def update
    @source = Source.find(params[:id])
    respond_to do |format|
    	
      if @source.update!(source_params) 
        format.html { redirect_to :back, notice: "Source was successfully updated." }
        format.json { head :ok }
      else
        format.html { redirect_to :back }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source = Source.find(params[:id])
    @source.destroy

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
    def source_params

    	params.require(:source).permit(:name, :reserve)
    	#source_params[:sources] = params["sources"]

    end
  
end
