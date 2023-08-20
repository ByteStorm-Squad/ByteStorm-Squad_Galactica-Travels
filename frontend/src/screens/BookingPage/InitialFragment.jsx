import React, { useState } from 'react';
import TextBox from '../../components/TextBox/TextBox';
import Button from '../../components/Button/Button';
import { getNextFlights } from '../../hooks/Booking/bookingApi';

const InitialFragment = ({ incrementFragmentNo, bookingData, setBookingData }) => {
  const [departure, setDeparture] = useState('');
  const [destination, setDestination] = useState('');

  const handleContinue = async () => {
    try {
      const data = await getNextFlights(journeyID);
      setJourneyData(data);
    } catch (error) {
      console.error('Error fetching journey data:', error);
    }
  };

  return (
    <>
      <div className="my-8 mx-8">
        <h2>Passenger Details</h2>
      </div>
      <TextBox text={'Departure'} />
      <TextBox text={'Destination'} />
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default InitialFragment;
