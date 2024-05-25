import React, {Fragment, useState, useEffect} from 'react'
import GetCSRFToken from '../../utils/Helpers/GetCSRFToken'
import styled from 'styled-components'
import PokemonForm from './PokemonForm'

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

const CreatePokemon = (props) => {
    const [pokemon, setPokemon] = useState({})
    const [optionsList, setOptionsList] = useState([]);
    const [error, setError] = useState('')

    const handleChange = (e) => {
        setPokemon(Object.assign({}, pokemon, {[e.target.name]: e.target.value, image_url: optionsList.find(p => p.name.toLowerCase() === e.target.value.toLowerCase()).imageUrl}))
    }

    useEffect(() => {
        const fetchNameList = async () => {
            try {
                const response = await fetch('https://pokeapi.co/api/v2/pokemon?limit=30');
                const data = await response.json();
                const promises = data.results.map(async (pokemon) => {
                    const pokemonDetailsResponse = await fetch(pokemon.url);
                    const pokemonDetails = await pokemonDetailsResponse.json();
                    return {
                        name: pokemon.name,
                        imageUrl: pokemonDetails.sprites.front_default,
                    };
                });

                const detailedPokemonList = await Promise.all(promises);
                setOptionsList(detailedPokemonList);
            } catch (error) {
                console.error('Error fetching names list:', error);
            }
        };

        fetchNameList();
    }, []);

    // Create review
    const handleSubmit = (e) => {
        e.preventDefault();

        fetch('/api/v1/pokemons', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': GetCSRFToken(),
            },
            credentials: 'include',
            body: JSON.stringify({ ...pokemon })
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
                        <h1>Add New Pokemon</h1>
                    </Main>
                </Column>
                <Column>
                    <PokemonForm
                        pokemon={pokemon}
                        availableNames={optionsList}
                        handleChange={handleChange}
                        handleSubmit={handleSubmit}
                        error={error}
                    />
                </Column>
            </Fragment>
        </Wrapper>
    )
}

export default CreatePokemon