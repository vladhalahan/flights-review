# frozen_string_literal: true

module Api
  module V1
    class PokemonsController < ApiController

      before_action :authenticate, only: %i[create destroy]
      before_action :authorize_user, only: %i[show create destroy]

      # GET /api/v1/pokemons
      def index
        render json: serializer(pokemons, options)
      end

      # GET /api/v1/pokemons/:slug
      def show
        render json: serializer(pokemon, options)
      end

      # POST /api/v1/pokemons
      def create
        pokemon = Pokemon.new(pokemon_params)

        if pokemon.save
          render json: serializer(pokemon)
        else
          render json: errors(pokemon), status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/pokemons/:slug
      def destroy
        if pokemon.destroy
          render json: { message: 'Destroyed successfully' }, status: :ok
        else
          render json: errors(pokemon), status: :unprocessable_entity
        end
      end

      private

      def authorize_user
        authorize Pokemon
      end

      # Used For compound documents with fast_jsonapi
      def options
        @options ||= { include: %i[reviews] }
      end

      # Get all pokemons
      def pokemons
        @pokemons ||= Pokemon.includes(reviews: :user).all
      end

      # Get a specific pokemon
      def pokemon
        @pokemon ||= Pokemon.includes(reviews: :user).find_by(slug: params[:slug])
      end

      # Strong params
      def pokemon_params
        params.require(:pokemon).permit(:name, :image_url)
      end

      # fast_jsonapi serializer
      def serializer(records, options = {})
        PokemonSerializer
          .new(records, options)
          .serialized_json
      end

      # Errors
      def errors(record)
        { errors: record.errors.messages }
      end

    end
  end
end
