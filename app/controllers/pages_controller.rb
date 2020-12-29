class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:my_counters, :admin_page]

  def my_counters
    @headcounts = Headcount.all
  end

  def scan_code

  end

  def home

  end

  def user_page
    if !session[:unlock_counter].blank?
      puts "********** session[:unlock_counter] pt2 *************"
      puts session[:unlock_counter]

      unlock = session[:unlock_counter].to_h
      unlock_type = unlock['type']
      id = unlock['id']
      headcount = Headcount.find(id)
      @headcount = headcount 
      @unlock_type = unlock_type
    else
      redirect_to root_path
    end
    # if params[:entrance] && !params[:entrance].blank? 
    #   entrance_code = params[:entrance]
    #   headcount = Headcount.find_by_entrance_code(entrance_code)
    #   if !headcount.blank?
    #     @headcount = headcount
    #     @entrance_user = true 
    #   end
    # end
    # if params[:exit] && !params[:exit].blank? 
    #   exit_code = params[:exit] 
    #   headcount = Headcount.find_by_exit_code(exit_code)
    #   if !headcount.blank?
    #     @headcount = headcount
    #     @exit_user = true
    #   end
    # end
  end

  def admin_page
    user = current_user 
    if params[:id]
      headcount = Headcount.find(params[:id])
      if headcount && headcount.user == user 
        @headcount = headcount
        if params[:type]
          @unlock_type = params[:type]
        end
      else
        redirect_to root_path
      end
    end
  end

end
