class HomeController < ApplicationController
  def index
  end

  def upload
    salesData = params[:file].read
    if salesData.length > 0
      if SalesData.validate(salesData)
        begin
          SalesData.handle(salesData)
          message = {
              status: 'success',
              message: 'The sales data was successfully uploaded and handled'
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
