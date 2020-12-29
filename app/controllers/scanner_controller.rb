class ScannerController < ApplicationController
  def index
  end

  def scan_result
    qr_code_params = JSON.parse(params[:qr_code_json_data]).with_indifferent_access
    qr_data = qr_code_params[:qr_data].to_s
    if qr_data.start_with?('telecounter')
      puts "************* scanned qr code ***************"
      puts qr_data
      unlock_counter = {}
      if qr_data.end_with?('qr')
        headcount = Headcount.find_by_qr_code(qr_data)
        if !headcount.blank?
          unlock_counter[:id] = headcount.id 
          unlock_counter[:type] = 'both'
          session[:unlock_counter] = unlock_counter
        end
      elsif qr_data.end_with?('entrance')
        headcount = Headcount.find_by_entrance_code(qr_data)
        if !headcount.blank?
          unlock_counter[:id] = headcount.id 
          unlock_counter[:type] = 'entrance'
          session[:unlock_counter] = unlock_counter
        end
      elsif qr_data.end_with?('exit')
        headcount = Headcount.find_by_exit_code(qr_data)
        if !headcount.blank?
          unlock_counter[:id] = headcount.id 
          unlock_counter[:type] = 'exit'
          session[:unlock_counter] = unlock_counter
        end
      end
      redirect_to pages_user_page_path
    else
      # Don't bother
      redirect_to scanner_index_path
    end
  end
end
