import GetCSRFToken from '../Helpers/GetCSRFToken'

const Authenticate = async () => {
  let auth = { isAuth: false, email: '' }

  try {
    const response = await fetch('/api/v1/auth/me', {
      method: 'GET',
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': GetCSRFToken() },
      credentials: 'include'
    });

    if (response.ok) {
      const data = await response.json();
      auth = { isAuth: data.logged_in, email: data.email, role: data.role };
    } else {
      console.log('Error:', response.statusText);
    }
  } catch (err) {
    console.log(err);
  }

  return auth;
}

export default Authenticate;