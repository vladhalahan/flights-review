import React, { useState, useEffect, Fragment } from 'react'
import styled from 'styled-components'
import Header from './Header'
import Review from '../Review/Review'
import ReviewForm from '../Review/ReviewForm'

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

const Airline = (props) => {
  const [airline, setAirline] = useState({})
  const [airlineAttributes, setAirlineAttributes] = useState({})
  const [reviews, setReviews] = useState([])
  const [review, setReview] = useState({ title: '', description: '', score: 0 })
  const [error, setError] = useState('')
  const [loaded, setLoaded] = useState(false)


  async function fetchData() {
    const slug = props.match.params.slug
    let resourceURL = `/api/v1/airlines/${slug}`

    return await (await fetch(resourceURL, { method: 'GET' })).json()
  }

  const fetchAirlineData = async () => {
    let response = await fetchData()

    setAirline(response.data)
    setAirlineAttributes(response.data.attributes)
    setReviews(response.data.included)
    setLoaded(true)
  }

  useEffect(()=> {
    fetchAirlineData()
  }, [])

  // Modify text in review form
  const handleChange = (e) => {
    setReview(Object.assign({}, review, {[e.target.name]: e.target.value}))
  }

  // Create review
  async function handleSubmit(e) {
    e.preventDefault()

    const airline_id = parseInt(airline.data.id)
    const fetchResponse = await fetch('/api/v1/reviews', {
      method: 'POST',
      body: { ...review, airline_id },
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    })
    const response = await fetchResponse.json()

    if (response.success) {
      setReviews([...reviews, response.data])
      setReview({ title: '', description: '', score: 0 })
      setError('')
    } else {
      response.error && setError(error)
    }
  }

  // Destroy a review
  const handleDestroy = (id, e) => {
    e.preventDefault()

    // AxiosWrapper.delete(`/api/v1/reviews/${id}`)
    // .then( (data) => {
    //   const included = [...reviews]
    //   const index = included.findIndex( (data) => data.id == id )
    //   included.splice(index, 1)
    //
    //   setReviews(included)
    // })
    // .catch( data => console.log('Error', data) )
  }

  // set score
  const setRating = (score, e) => {
    e.preventDefault()  
    setReview({ ...review, score })
  }

  let total, average = 0
  let userReviews

  if (reviews && reviews.length > 0) {
    total = reviews.reduce((total, review) => total + review.attributes.score, 0)
    average = total > 0 ? (parseFloat(total) / parseFloat(reviews.length)) : 0
    
    userReviews = reviews.map( (review, index) => {
      return (
        <Review
          key={index}
          id={review.id}
          attributes={review.attributes}
          handleDestroy={handleDestroy}
        />
      )
    })
  }

  return(
    <Wrapper>
      { 
        loaded &&
        <Fragment>
          <Column>
            <Main>
              <Header 
                attributes={airlineAttributes}
                reviews={reviews}
                average={average}
              />
              {userReviews}
            </Main>
          </Column>
          <Column>
            <ReviewForm
              name={airlineAttributes.name}
              review={review}
              handleChange={handleChange}
              handleSubmit={handleSubmit}
              setRating={setRating}
              error={error}
            />
          </Column>
        </Fragment>
      }
    </Wrapper>
  )
}

export default Airline
