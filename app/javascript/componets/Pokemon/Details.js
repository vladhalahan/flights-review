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
  width:15%;
  font-size:16px;
  cursor: pointer;
  transition: ease-in-out 0.2s;
  &:hover {
    background: red;
  }
`

const StatsWrapper = styled.div`
    display: flex;
    gap: 20px; /* Optional: adds space between columns */
    
    div {
        flex: 1; /* Each child takes up an equal amount of space */
    }
`

const Abilities = ({ abilities }) => {
    return (
        <div>
            Abilities
            {abilities.map((ability, index) => (
                <p style={{fontSize: '11px'}} key={index}>{ability}</p>
            ))}
        </div>
    );
};

const Stats = ({ stats }) => {
    return (
        <div>
            Stats
            {stats.map((stat, index) => {
                const [key, value] = Object.entries(stat)[0];
                return <p style={{fontSize: '11px'}} key={index}>{`${key}: ${value}`}</p>;
            })}
        </div>
    );
};

const Details = ({attributes, reviews, average, ...props}) => {
  const { image_url, name, stats, abilities } = attributes

  return (
      <AuthConsumer>
          { ({ role }) => (
              <Wrapper>
                  <h1><img src={image_url} height="50" width="50" alt={name} /> {name}</h1>
                  <StatsWrapper>
                      {abilities.length > 0 && <Abilities abilities={abilities} />}
                      {stats.length > 0 && <Stats stats={stats} />}
                  </StatsWrapper>
                  {role === 'admin' && <DestroyBtn onClick={props.handlePokemonDestroy.bind(this, props.slug)}>Destroy</DestroyBtn>}
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