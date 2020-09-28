class HomeController < ApplicationController
  def index
    @data = SalesData.flattened
    @total_revenue = 0
    @data.each do |row|
      @total_revenue += row[:"Item Price"] * row[:Quantity]
    end
  end

  def upload
    sales_data = params[:file].read
    if sales_data.length > 0
      if SalesData.validate(sales_data)
        begin
          SalesData.import(sales_data)
          message = {
              status: 'success',
              message: 'The sales data was successfully uploaded and imported, automatically reloading page in 3 seconds'
          }
          render json: message
        rescue
          message = {
              status: 'error',
              message: 'There was a problem with handling the sales data'
          }
          render json: message
        end
      else
        message = {
            status: 'error',
            message: 'The sales data contents are invalid for upload'
        }
        render json: message
      end
    else
      message = {
          status: 'error',
          message: 'The sales data contents were empty'
      }
      render json: message
    end
  end
end
