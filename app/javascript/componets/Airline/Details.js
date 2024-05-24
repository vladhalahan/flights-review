import React from 'react'
import styled from 'styled-components'
import Rating from '../Rating/Rating'
import { AuthConsumer } from '../AuthContext'

const Wrapper = styled.div`
  padding: 50px 100px 50px 0px;
  font-size:30px;
  img {
    margin-right: 10px;
    height: 60px;
    width: 60px;
    border: 1px solid rgba(0,0,0,0.1);
    border-radius: 100%;
    margin-bottom: -8px;
  }
`

const UserReviewCount = styled.div`
  font-size: 18px;
  padding:10px 0;
`

const ScoreOutOf = styled.div`
  padding-top: 12px;
  font-size: 18px;
  font-weight: bold;
`

const DestroyBtn = styled.button`
  color: black;
  background-color: grey;
  border-radius: 4px;   
  padding:12px 12px;  
  border: 1px solid #71b406;
  width:10%;
  font-size:16px;
  cursor: pointer;
  transition: ease-in-out 0.2s;
  &:hover {
    background: red;
  }
`

const Details = ({attributes, reviews, average, ...props}) => {
  const { image_url, name } = attributes

  return (
      <AuthConsumer>
          { ({ role }) => (
              <Wrapper>
                  <h1><img src={image_url} height="50" width="50" alt={name} /> {name}</h1>
                  {role === 'admin' && <DestroyBtn onClick={props.handleAirlineDestroy.bind(this, props.id)}>Destroy</DestroyBtn>}
                  <div>
                      <UserReviewCount>
                          <span className="review-count">{reviews ? reviews.length : 0}</span> user reviews
                      </UserReviewCount>
                      <Rating score={average} />
                      <ScoreOutOf>{average.toFixed(1)} out of 5 stars</ScoreOutOf>
                  </div>
              </Wrapper>
          ) }
      </AuthConsumer>

  )
}

export default Details