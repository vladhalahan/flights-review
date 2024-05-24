import React, {Component, createContext} from 'react'
import Authenticate from '../utils/Auth/Authenticate'
import GetCSRFToken from '../utils/Helpers/GetCSRFToken'

const AuthContext = createContext()

class AuthProvider extends Component {
  state = { isAuth: false, email: '' }

  constructor(props){
    super(props)
  }

  componentDidMount(){
    Authenticate()
        .then((resp) => this.setState({ ...resp }))
        .catch((err) => console.log(err))
  }

  login = (user, props, e) => {
    e.preventDefault();

    fetch('/api/v1/auth', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': GetCSRFToken() },
      credentials: 'include',
      body: JSON.stringify({ user: { ...user } })
    })
        .then(response => response.json())
        .then(_resp => {
          this.setState({ isAuth: true });
          window.location.href = '/'
        })
        .catch(err => console.log(err));
  }

  signup = (user, props, e) => {
    e.preventDefault();

    fetch('/api/v1/registrations', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': GetCSRFToken() },
      credentials: 'include',
      body: JSON.stringify({ user: { ...user } })
    })
        .then(response => response.json())
        .then(resp => {
          this.setState({ isAuth: true });
          window.location.href = '/'
        })
        .catch(err => console.log(err));
  }

  logout = (e) => {
    e.preventDefault();

    fetch('/api/v1/auth/logout', {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': GetCSRFToken(),
      },
      credentials: 'include'
    })
        .then(response => response.json())
        .then(_resp => {
          this.setState({ isAuth: false });
          window.location.href = '/'
        })
        .catch(err => console.log(err));
  }

  render() {
    return (
        <AuthContext.Provider
            value={{
              isAuth: this.state.isAuth,
              email: this.state.email,
              signup: this.signup,
              login: this.login,
              logout: this.logout,
            }}
        >
          {this.props.children}
        </AuthContext.Provider>
    )
  }
}
//
const AuthConsumer = AuthContext.Consumer

export { AuthProvider, AuthConsumer }
