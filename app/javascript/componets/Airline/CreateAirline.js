import React, {Fragment, useState} from 'react'
import GetCSRFToken from '../../utils/Helpers/GetCSRFToken'
import styled from 'styled-components'
import AirlineForm from './AirlineForm'

const Wrapper = styled.div`
  margin-left: auto;
  margin-right: auto;
`

const Column = styled.div`
  background: #fff; 
  max-width: 50%;
  width: 50%;
  float: left; 
  height: 100vh;
  overflow-x: scroll;
  overflow-y: scroll; 
  overflow: scroll;

  &::-webkit-scrollbar {
    display: none;
  }

  &:last-child {
    background: black;
    border-top: 1px solid rgba(255,255,255,0.5);
  }
`

const Main = styled.div`
  padding-left: 60px;
`

const CreateAirline = (props) => {
    const [airline, setAirline] = useState({})
    const [error, setError] = useState('')

    const handleChange = (e) => {
        setAirline(Object.assign({}, airline, {[e.target.name]: e.target.value}))
    }

    // Create review
    const handleSubmit = (e) => {
        e.preventDefault();

        fetch('/api/v1/airlines', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': GetCSRFToken(),
            },
            credentials: 'include',
            body: JSON.stringify({ ...airline })
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Request failed with status code ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                setError('');
                window.location.href = '/'
            })
            .catch(error => {
                let errorMessage;
                switch (error.message) {
                    case 'Request failed with status code 401':
                        errorMessage = 'You have no permissions to perform this action.';
                        break;
                    default:
                        errorMessage = 'Something went wrong.';
                }
                setError(errorMessage);
            });
    }

    return(
        <Wrapper>
            <Fragment>
                <Column>
                    <Main>
                        <h1>Add New Airline</h1>
                    </Main>
                </Column>
                <Column>
                    <AirlineForm
                        airline={airline}
                        handleChange={handleChange}
                        handleSubmit={handleSubmit}
                        error={error}
                    />
                </Column>
            </Fragment>
        </Wrapper>
    )
}

export default CreateAirline