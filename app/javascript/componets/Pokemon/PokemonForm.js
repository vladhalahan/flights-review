import React from "react"
import styled from 'styled-components'

const Field = styled.div`
  border-radius: 4px;

  input {
    width: 96%;
    min-height:50px;
    border: 1px solid #E6E6E6;
    margin: 12px 0;
    padding: 12px;
  }
  
  select {
    width: 99%;
    min-height:45px;
    border: 1px solid #E6E6E6;
    margin: 12px 0;
    padding: 12px;
  }
 
`

const SubmitBtn = styled.button`
  color: #fff;
  background-color: #71b406;
  border-radius: 4px;   
  padding:12px 12px;  
  border: 1px solid #71b406;
  width:100%;
  font-size:18px;
  cursor: pointer;
  transition: ease-in-out 0.2s;
  &:hover {
    background: #71b406;
    border-color: #71b406;
  }
`

const PokemonWrapper = styled.div`
  background:white;
  padding:20px;
  margin-left: 15px;
  border-radius: 0;
  padding-bottom:80px;
  border-left: 1px solid rgba(0,0,0,0.1);
  height: 100vh;
  padding-top: 100px;
  background: black;
  padding-right: 80px;
`

const Error = styled.div`
  width: 100%;
  color: rgb(255, 80, 44);
  border: 1px solid rgb(255, 80, 44);
  border-radius: 4px;
  margin-top: 8px;
  text-align:center;
  padding: 4px;
`

const PokemonForm = (props) =>{
    return (
        <PokemonWrapper>
            <form onSubmit={props.handleSubmit}>
                <Field>
                    <select onChange={props.handleChange} name="name" value={props.pokemon.title}>
                        <option value="" disabled>Select Pokemon Name</option>
                        {props.availableNames.map((option) => (
                            <option key={option.imageUrl} value={option.name}>
                                {option.name}
                            </option>
                        ))}
                    </select>
                </Field>
                <SubmitBtn type="Submit">Create Pokemon</SubmitBtn>
                {
                    props.error &&
                    <Error>{props.error}</Error>
                }
            </form>
        </PokemonWrapper>
    )
}

export default PokemonForm
