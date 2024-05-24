import React from "react"
import styled from 'styled-components'

const Field = styled.div`
  border-radius: 4px;

  input {
    width: 96%;
    min-height:50px;
    border-radius: 4px;
    border: 1px solid #E6E6E6;
    margin: 12px 0;
    padding: 12px;
  }
  
  textarea {
    width: 100%;
    min-height:80px;
    border-radius: 4px;
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

const AirlineWrapper = styled.div`
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

const AirlineForm = (props) =>{
    return (
        <AirlineWrapper>
            <form onSubmit={props.handleSubmit}>
                <Field>
                    <input onChange={props.handleChange} type="text" name="name" placeholder="Airline Name" value={props.airline.title}/>
                </Field>
                <Field>
                    <input onChange={props.handleChange} type="text" name="image_url" placeholder="Airline Logo URL" value={props.airline.image_url}/>
                </Field>
                <SubmitBtn type="Submit">Create Airline</SubmitBtn>
                {
                    props.error &&
                    <Error>{props.error}</Error>
                }
            </form>
        </AirlineWrapper>
    )
}

export default AirlineForm
