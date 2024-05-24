import React, { useState, useEffect, Fragment } from 'react'
import styled from 'styled-components'
import Details from './Details'
import Review from '../Review/Review'
import ReviewForm from '../Review/ReviewForm'
import GetCSRFToken from '../../utils/Helpers/GetCSRFToken'

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

    return await (await fetch(resourceURL, { method: 'GET', headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': GetCSRFToken() }})).json()
  }

  const fetchAirlineData = async () => {
    let response = await fetchData()

    setAirline(response.data)
    setAirlineAttributes(response.data.attributes)
    setReviews(response.included)
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
  const handleSubmit = (e) => {
    e.preventDefault();

    const airline_id = parseInt(airline.id);
    fetch('/api/v1/reviews', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': GetCSRFToken(),
      },
      credentials: 'include',
      body: JSON.stringify({ ...review, airline_id })
    })
        .then(response => {
          if (!response.ok) {
            throw new Error(`Request failed with status code ${response.status}`);
          }
          return response.json();
        })
        .then(data => {
          setReviews([...reviews, data.data]);
          setReview({ title: '', description: '', score: 0 });
          setError('');
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

  // Destroy a review
  const handleDestroy = (id, e) => {
    e.preventDefault();

    fetch(`/api/v1/reviews/${id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': GetCSRFToken(),
      },
      credentials: 'include'
    })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          const included = [...reviews];
          const index = included.findIndex((item) => item.id == id);
          included.splice(index, 1);

          setReviews(included);
        })
        .catch(error => console.log('Error', error));
  }

  // Destroy a airline
  const handleAirlineDestroy = (id, e) => {
    e.preventDefault();

    fetch(`/api/v1/airlines/${id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': GetCSRFToken(),
      },
      credentials: 'include'
    })
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          window.location.href = '/'
        })
        .catch(error => console.log('Error', error));
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
    const sortedReviews = reviews.sort((a, b) => new Date(b.attributes.created_at) - new Date(a.attributes.created_at));
    userReviews = sortedReviews.map( (review, index) => {
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
              <Details
                id={airline.id}
                attributes={airlineAttributes}
                reviews={reviews}
                average={average}
                handleAirlineDestroy={handleAirlineDestroy}
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
