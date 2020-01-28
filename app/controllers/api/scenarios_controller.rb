module Api
  class ScenariosController < ApplicationController
    def create

    end

    def destroy

    end

    def info
      @return = return_error(:id_required) if params[:id].blank?
      @return = return_error(:password_required) if params[:password].blank?

      if Scenario.exists?(id: params[:id])
        scenario = Scenario.find(params[:id])
        if scenario.authenticate(params[:password])
          @return = return_success(scenario)
        else
          @return = return_error(:authentification_failed)
        end
      else
        @return = return_error(:record_not_found)
      end

      render json: @return
    end

    def authenticated

    end

    private

    def return_error(error)
      {success: false, error: error}
    end

    def return_success(result)
      {success: true, result: result.to_json}
    end
  end
end