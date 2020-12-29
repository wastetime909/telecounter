class HeadcountsController < ApplicationController
  before_action :authenticate_user!, except: [:new_entrance, :new_exit]
  
  def index 
    user = current_user 
    @headcounts = user.headcounts 
  end
  
  def show 
    require 'rqrcode'
    user = current_user
    id = params[:id]
    headcount = Headcount.find(id)
    if headcount && headcount.user == user 
      @headcount = headcount 
      qr_code = headcount.qr_code
      entrance_code = headcount.entrance_code 
      exit_code = headcount.exit_code 

      #   Create qr code for each entry code
      qr_code = RQRCode::QRCode.new(headcount.qr_code)
      entrance_code = RQRCode::QRCode.new(headcount.entrance_code) 
      exit_code = RQRCode::QRCode.new(headcount.exit_code)

      qr_img = qr_code.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: 'black',
        file: nil,
        fill: 'white',
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 320
      )
      entrance_img = entrance_code.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: 'black',
        file: nil,
        fill: 'white',
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 320
      )
      exit_img = exit_code.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: 'black',
        file: nil,
        fill: 'white',
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 320
      )

      @qr_img = qr_img.to_image.to_data_url
      @entrance_img = entrance_img.to_image.to_data_url 
      @exit_img = exit_img.to_image.to_data_url 

    end
  end

  def new 
    user = current_user 
    @headcount = user.headcounts.new
  end
  
  def create 
    user = current_user 
    headcount = user.headcounts.create(headcount_params)
    time_stamp = Time.now.to_f.to_i.to_s
    random_letters1 = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    random_letters2 = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    random_letters3 = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    random_letters4 = (0...4).map { ('a'..'z').to_a[rand(26)] }.join

    headcount.qr_code = 'telecounter' + time_stamp + random_letters1 + 'qr'
    headcount.entrance_code = 'telecounter' + time_stamp + random_letters2 + 'entrance'
    headcount.exit_code = 'telecounter' + time_stamp + random_letters3 + 'exit'
    headcount.stamp = 'telecounter' + time_stamp + random_letters4 + 'stamp'
    if headcount.save
      redirect_to pages_my_counters_path
    end

  end

  def update 

  end

  def delete 

  end

  def destroy 

  end

  def new_entrance
    stamp = params[:id]
    quant = params[:quant].to_i
    headcount = Headcount.find_by_stamp(stamp)
    current_count = headcount.current_count 
    current_count += quant
    headcount.current_count = current_count 
    headcount.save 
    @id = headcount.stamp
    @current_count = current_count
    AddNewEntranceJob.perform_later(@id, @current_count)
  end

  def new_exit
    stamp = params[:id]
    quant = params[:quant].to_i
    headcount = Headcount.find_by_stamp(stamp)
    current_count = headcount.current_count 
    if current_count > 0
      current_count -= quant 
      current_count = [current_count, 0].max
      headcount.current_count = current_count 
      headcount.save 
      @id = headcount.stamp
      @current_count = current_count
      AddNewEntranceJob.perform_later(@id, @current_count)
    end
  end

  private 

  def headcount_params
    params.require(:headcount).permit(:nickname, :max_count)
  end

end
