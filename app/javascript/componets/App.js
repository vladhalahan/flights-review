import React from 'react'
import { Route, Switch } from 'react-router-dom'

import Login from './Auth/Login'
import Register from './Auth/Register'
import Pokemons from './Pokemons/Pokemons'
import Pokemon from './Pokemon/Pokemon'
import CreatePokemon from './Pokemon/CreatePokemon'
import Navbar from './Navbar'
import {AuthProvider} from './AuthContext'
import ProtectedRoute from './ProtectedRoute'
import UnprotectedRoute from './UnprotectedRoute'

const App = () => {
    return (
        <AuthProvider>
            <Navbar/>
            <Switch>
                <Route exact path="/" component={Pokemons} />
                <ProtectedRoute exact path="/pokemons/:slug" component={Pokemon} />
                <ProtectedRoute exact path="/create-pokemon" component={CreatePokemon} />
                <UnprotectedRoute path="/login" component={Login}/>
                <UnprotectedRoute exact path="/register" component={Register} />
            </Switch>
        </AuthProvider>
    )
}

export default App
