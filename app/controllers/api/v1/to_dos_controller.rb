module Api
  module V1
    class ToDosController < ApplicationController
      before_action :to_do, only: %i[show update destroy]
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def index
        @to_dos = ToDo.all
      end

      def show; end

      def create
        @to_do = ToDo.create(to_do_params)

        if @to_do.save
          render json: @to_do, status: :created
        else
          render json: @to_do.errors, status: :unprocessable_entity
        end
      end

      def update
        if @to_do.update(to_do_params)
          render json: @to_do, status: :created
        else
          render json: @to_do.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @to_do.destroy
      end

      private

      def to_do_params
        params.permit(:title, :body, :end_date)
      end

      def to_do
        @to_do = ToDo.find(params[:id])
      end

      def not_found
        head :not_found
      end
    end
  end
end
