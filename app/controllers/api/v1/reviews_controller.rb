# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApiController
      before_action :authenticate

      # POST /api/v1/reviews
      def create
        review = current_user.reviews.new(review_params)
        authorize review

        if review.save
          render json: serializer(review)
        else
          render json: errors(review), status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/reviews/:id
      def destroy
        review = current_user.reviews.find(params[:id])
        authorize review

        if review.destroy
          render json: { message: 'Destroyed successfully' }, status: :ok
        else
          render json: errors(review), status: :unprocessable_entity
        end
      end

      private

      # Strong params
      def review_params
        params.require(:review).permit(:title, :description, :score, :pokemon_id)
      end

      # fast_jsonapi serializer
      def serializer(records, options = {})
        ReviewSerializer
          .new(records, options)
          .serialized_json
      end

      def errors(record)
        { errors: record.errors.messages }
      end
    end
  end
end
