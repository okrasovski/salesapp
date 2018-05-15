module SalesHelper

	def sale_dependencies sale_params
    
    sale_params[:positions].each_pair do |name, amount|
      unless amount.blank?
        @product = @products.find_by_name(name)
        @product.update_attributes(
          {:sales_amount => @product.sales_amount + amount.to_i, 
            :sum_total => @product.sum_total + @product.price*amount.to_i,
            :last_sale_at => Time.now})   
        
        @product.sources.each_pair do |source_name, source_amount| 
          @source = @sources.find_by_name(source_name) #source itself
          @source.update_attributes(
            {:reserve =>  @source.reserve - @source_amount.to_i*amount.to_i}
          )
        end             
      end
    end
    current_user.update_attributes({:sales_sum_total => 
	   	current_user.sales_sum_total + sale_params[:sale_sum]})
    return true
    
  end

  def update_clients qrcode_image_tempfile, sale_sum

  	qrcode_info = ZBar::Image.from_jpeg(File.binread(
  		qrcode_image_tempfile)).process[0].data

  	@client = Client.find(qrcode_info.to_i).tap do |c|
	  	c.bonus_sum += (sale_sum * 0.01).round
	  	c.last_sale_at = Time.now 
	  	c.save!
	  end
  end

  def new_qrcode
		
		@client = Client.new(:join_at => Time.now)
		@client.save!

		qrcode = RQRCode::QRCode.new(@client.id.to_s).as_png(size: 360)

		("#{Rails.root}/tmp/#{@client.id}.jpg").tap do |src|		
			MiniMagick::Image.read(qrcode.to_blob).format("jpg").write(src)
			return src.gsub("#{Rails.root}/", root_path)
		end
	end  

end


