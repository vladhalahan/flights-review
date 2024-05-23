import React, { useState, useEffect } from 'react'
import Airline from './Airline'
import Header from './Header'
import styled from 'styled-components'

const Home = styled.div`
  text-align:center;
  margin-left: auto;
  margin-right: auto;
  max-width: 1200px;
`

const Grid = styled.div`
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-gap: 20px;
  width: 100%;
  padding: 20px;

  > div {
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
  }
`

const Airlines = () => {
  const [airlines, setAirlines] = useState([]);

  async function fetchData() {
    let resourceURL = '/api/v1/airlines.json'

    return await (await fetch(resourceURL, { method: 'GET' })).json()
  }

  const fetchAirlines = async () => {
    let response = await fetchData()
    setAirlines(response.data)
  }

  useEffect(() => {
    fetchAirlines()
  }, [])

  const grid = airlines.map( (airline, index) => {
    const { name, image_url, slug, average_score } = airline.attributes

    return (
      <Airline
        key={index}
        name={name}
        image_url={image_url}
        slug={slug}
        average_score={average_score}
      />
    )
  })

  return (
    <Home>
      <Header/>
      <Grid>{grid}</Grid>
    </Home>
  )
}

export default Airlines