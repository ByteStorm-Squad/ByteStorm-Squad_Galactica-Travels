import React from 'react';
import JourneyCard from '../../components/JourneyCard/JourneyCard';

const JourneysFragment = ({ incrementFragmentNo, bookingData, setBookingData }) => {
  const onSelectJourney = journeyID => {
    incrementFragmentNo();
    setBookingData({ ...bookingData, selectedJourney: journeyID });
    console.log(bookingData);
  };

  return (
    <>
      <div className="my-8 mx-8">
        <h2>Available Journeys</h2>
      </div>
      {bookingData.availableJourneys.map(journey => (
        <JourneyCard
          key={journey.journey_id}
          spaceship={`Cruiser Class ${journey.spacecraft_id}`}
          journeyCode={journey.journey_id}
          departure={bookingData.departure}
          destination={bookingData.destination}
          status={journey.flight_status}
          departure_time={journey.departure_date}
          onClick={() => onSelectJourney(journey.journey_id)}
        />
      ))}
    </>
  );
};

export default JourneysFragment;
