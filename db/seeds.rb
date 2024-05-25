# frozen_string_literal: true

# Seeding pokemons
%w[wartortle kakuna pidgeot weedle].each { |name| Pokemons::Create.call({ name: name }) }

# Seeding admin user
User.create(email: 'admin@example.com', password: 'password', role: User.roles[:admin])
User.create(email: 'another@example.com', password: 'password')
