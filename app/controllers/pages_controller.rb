class PagesController < ApplicationController
  def my_counters
    @headcounts = Headcount.all
  end

  def user_page
    if params[:entrance] && !params[:entrance].blank? 
      entrance_code = params[:entrance]
      headcount = Headcount.find_by_entrance_code(entrance_code)
      if !headcount.blank?
        @headcount = headcount
        @entrance_user = true 
      end
    end
    if params[:exit] && !params[:exit].blank? 
      exit_code = params[:exit] 
      headcount = Headcount.find_by_exit_code(exit_code)
      if !headcount.blank?
        @headcount = headcount
        @exit_user = true
      end
    end
  end

  def admin_page
  end

end
