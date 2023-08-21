import React, { useState } from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';
import PageIndicator from '../../components/PageIndicator/PageIndicator';
import InitialFragment from './InitialFragment';
import PassengersFragment from './PassengersFragment';
import TravelFragment from './TravelFragment';
import JourneysFragment from './JourneysFragment';
import PaymentFragment from './PaymentFragment';
import { useNavigate } from 'react-router-dom';

const BookingPage = () => {
  const [fragmentNo, setFragmentNo] = useState(0);
  const [bookingData, setBookingData] = useState({
    passengerCount: 1,
    departure: '',
    destination: '',
    availableJourneys: [],
    selectedJourney: '',
    selectedSeats: ['10C'],
  });
  const navigate = useNavigate();

  const handleBack = () => {
    if (fragmentNo > 0) {
      decrementFragmentNo();
    } else {
      navigate(-1);
    }
  };

  const incrementFragmentNo = () => {
    setFragmentNo(fragmentNo + 1);
  };

  const decrementFragmentNo = () => {
    setFragmentNo(fragmentNo - 1);
  };

  let selectedFragment;
  switch (fragmentNo) {
    case 0:
      selectedFragment = (
        <InitialFragment incrementFragmentNo={incrementFragmentNo} bookingData={bookingData} setBookingData={setBookingData} />
      );
      break;
    case 1:
      selectedFragment = (
        <JourneysFragment incrementFragmentNo={incrementFragmentNo} bookingData={bookingData} setBookingData={setBookingData} />
      );
      break;
    case 2:
      selectedFragment = (
        <PassengersFragment incrementFragmentNo={incrementFragmentNo} bookingData={bookingData} setBookingData={setBookingData} />
      );
      break;
    case 3:
      selectedFragment = <TravelFragment incrementFragmentNo={incrementFragmentNo} />;
      break;
    case 4:
      selectedFragment = <PaymentFragment incrementFragmentNo={incrementFragmentNo} />;
      break;
    default:
      selectedFragment = <div>Invalid Fragment Number</div>;
  }

  return (
    <>
      <PageHeader title="Booking" onBackPress={handleBack} />
      <PageIndicator pageNo={fragmentNo} />
      {selectedFragment}
    </>
  );
};

export default BookingPage;
