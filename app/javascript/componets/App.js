import React from 'react'
import { Route, Switch } from 'react-router-dom'

import Login from './Auth/Login'
import Register from './Auth/Register'
import Airlines from './Airlines/Airlines'
import Airline from './Airline/Airline'
import Navbar from './Navbar'
import {AuthProvider} from './AuthContext'
import ProtectedRoute from './ProtectedRoute'
import UnprotectedRoute from './UnprotectedRoute'

const App = () => {
    return (
        <AuthProvider>
            <Navbar/>
            <Switch>
                <Route exact path="/" component={Airlines} />
                <ProtectedRoute exact path="/airlines/:slug" component={Airline} />
                <UnprotectedRoute path="/login" component={Login}/>
                <UnprotectedRoute exact path="/register" component={Register} />
            </Switch>
        </AuthProvider>
    )
}

export default App
