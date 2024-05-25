## PokemonsReview
### A pokemon reviews CRUD app built with Ruby on Rails and React.js

This app is intended to be a simple example of a CRUD app built with **Ruby on Rails** and **React.js** using **Webpacker**.

add link to screencast here

---

## Running it locally
- run `rails db:prepare`
- run `yarn install`
- run `bundle exec rails s`
- in another tab run `./bin/webpack-dev-server` (optional)
- navigate to `http://localhost:3000`

## Routes
```shell
                                    root GET    /                                                                                                 pages#index
                         api_v1_pokemons GET    /api/v1/pokemons(.:format)                                                                        api/v1/pokemons#index
                                         POST   /api/v1/pokemons(.:format)                                                                        api/v1/pokemons#create
                      new_api_v1_pokemon GET    /api/v1/pokemons/new(.:format)                                                                    api/v1/pokemons#new
                     edit_api_v1_pokemon GET    /api/v1/pokemons/:slug/edit(.:format)                                                             api/v1/pokemons#edit
                          api_v1_pokemon GET    /api/v1/pokemons/:slug(.:format)                                                                  api/v1/pokemons#show
                                         PATCH  /api/v1/pokemons/:slug(.:format)                                                                  api/v1/pokemons#update
                                         PUT    /api/v1/pokemons/:slug(.:format)                                                                  api/v1/pokemons#update
                                         DELETE /api/v1/pokemons/:slug(.:format)                                                                  api/v1/pokemons#destroy
                          api_v1_reviews POST   /api/v1/reviews(.:format)                                                                         api/v1/reviews#create
                           api_v1_review DELETE /api/v1/reviews/:id(.:format)                                                                     api/v1/reviews#destroy
                    me_api_v1_auth_index GET    /api/v1/auth/me(.:format)                                                                         api/v1/auth#logged_in
                logout_api_v1_auth_index DELETE /api/v1/auth/logout(.:format)                                                                     api/v1/auth#logout
                       api_v1_auth_index POST   /api/v1/auth(.:format)                                                                            api/v1/auth#create
                    api_v1_registrations POST   /api/v1/registrations(.:format)                                                                   api/v1/registrations#create
```

## Features

### Authentication
Users can create accounts with a default role of "regular user" and leave reviews for any Pokémon. An admin role can be created by running rails db:seed or directly from the console.

### Authorization
By default, unauthorized users can only navigate to the root path and view the list of Pokémon. Once logged in, a regular user can create reviews on a Pokémon's page. Admin users cannot leave reviews. Instead, admin users have the ability to create and delete Pokémon entities. All authorization rules are managed by Pundit policies.

### Integrations
There is an integration with PokeAPI that admin users can utilize to create Pokémon. The user only needs to select the Pokémon's name and submit the form. The Pokémon will be created with the specified name and its image URL.