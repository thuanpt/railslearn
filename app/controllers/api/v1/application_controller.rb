module Api
  module V1
    class ApplicationController < ActionController::API
      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          decoded = JsonWebToken.decode(header)
          @current_user = User.find(decoded[:user_id]) if decoded
        rescue ActiveRecord::RecordNotFound, JWT::DecodeError
          render json: { errors: 'Unauthorized' }, status: :unauthorized
        end
        
        unless @current_user
          render json: { errors: 'Unauthorized' }, status: :unauthorized
        end
      end
    end
  end
end
