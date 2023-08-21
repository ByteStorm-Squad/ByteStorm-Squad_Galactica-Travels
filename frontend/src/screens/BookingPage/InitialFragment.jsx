import React, { useEffect, useState } from 'react';
import Button from '../../components/Button/Button';
import { getLocations, getNextFlights } from '../../hooks/Booking/bookingApi';
import DropDownList from '../../components/DropDownList/DropDownList';

const InitialFragment = ({ incrementFragmentNo, bookingData, setBookingData }) => {
  const [departure, setDeparture] = useState('');
  const [destination, setDestination] = useState('');
  const [locationsList, setLocationsList] = useState([]);

  const getLocationOptions = async () => {
    try {
      const data = await getLocations();
      console.log(data);
      setLocationsList(data?.locations);
    } catch (error) {
      console.error('Error fetching data', error);
    }
  };

  const handleContinue = async () => {
    incrementFragmentNo();
    try {
      const data = await getNextFlights(2, `${departure} to ${destination}`);
      setBookingData({ ...bookingData, departure: departure, destination: destination, availableJourneys: data?.nextFlight });
    } catch (error) {
      console.error('Error fetching journey data:', error);
    }
  };

  useEffect(() => {
    getLocationOptions();
  }, []);

  return (
    <>
      <div className="my-8 mx-8">
        <h2>Journey Details</h2>
      </div>
      <DropDownList label={'Departure'} value={departure} optionList={locationsList} onChange={e => setDeparture(e.target.value)} />
      <DropDownList label={'Destination'} value={destination} optionList={locationsList} onChange={e => setDestination(e.target.value)} />
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={handleContinue} />
      </div>
    </>
  );
};

export default InitialFragment;
