module Api
  module V1
    class ListsController < ApplicationController
      before_action :set_list, only: :show

      api :GET, '/lists', 'Get ALL ToDo lists'
      def index
        render json: ListBlueprint.render(List.shared, root: :lists), status: :ok
      end

      api :GET, '/lists/:id', 'Get ToDo list by ID'
      param :id, :number, required: true
      def show
        render json: ListBlueprint.render(@list, root: :list), status: :ok
      end

      private

      def set_list
        @list = List.shared.find(params[:id]) # consider using guid instead!
      rescue ActiveRecord::RecordNotFound
        record_not_found
      end
    end
  end
end
