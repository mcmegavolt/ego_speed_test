class RecordsController < ApplicationController
  
  before_action :set_record, :only => :show

  def index
    @records = Record.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end
   
end
