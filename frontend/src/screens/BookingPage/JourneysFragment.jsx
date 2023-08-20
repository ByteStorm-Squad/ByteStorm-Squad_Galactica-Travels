import React from 'react';
import JourneyCard from '../../components/JourneyCard/JourneyCard';

const JourneysFragment = ({ incrementFragmentNo, bookingData, setBookingData }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Available Journeys</h2>
      </div>
      <JourneyCard
        spaceship={'Cruiser Class II'}
        journeyCode={'F01'}
        departure={'1/1/2023 4PM'}
        arrival={'5/1/2023 7PM'}
        onClick={incrementFragmentNo}
      />
      <JourneyCard
        spaceship={'Voyager Class I'}
        journeyCode={'F02'}
        departure={'2/1/2023 4PM'}
        arrival={'4/1/2023 7PM'}
        onClick={incrementFragmentNo}
      />
    </>
  );
};

export default JourneysFragment;
