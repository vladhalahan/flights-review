# frozen_string_literal: true

# Seeding pokemons
Pokemon.create([
                 {
                   name: 'wartortle',
                   image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png'
                 },
                 {
                   name: 'kakuna',
                   image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/14.png'
                 },
                 {
                   name: 'pidgeot',
                   image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/18.png'
                 },
                 {
                   name: 'weedle',
                   image_url: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/13.png'
                 },
               ])

# Seeding admin user
User.create(email: 'admin@example.com', password: 'password', role: User.roles[:admin])
