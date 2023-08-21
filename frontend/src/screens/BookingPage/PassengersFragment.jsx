import React, { useEffect, useState } from 'react';
import Button from '../../components/Button/Button';
import TextBox from '../../components/TextBox/TextBox';
import PassengerCard from '../../components/PassengerCard/PassengerCard';
import DropDownList from '../../components/DropDownList/DropDownList';

const PassengersFragment = ({ incrementFragmentNo, bookingData, setBookingData }) => {
  const [passengerCount, setPassengerCount] = useState(1);

  const handleCountChange = e => {
    setPassengerCount(e.target.value);
    setBookingData({ ...bookingData, passengerCount: e.target.value });
  };

  useEffect(() => {
    // This code will run whenever passengerCount changes
    // You can add any logic here that you want to run when passengerCount changes
    console.log('Passenger count changed:', passengerCount);
  }, [passengerCount]); // The effect will be triggered only when passengerCount changes

  return (
    <>
      <div className="my-8 mx-8">
        <h2>Passenger Details</h2>
      </div>
      <div className="my-8 mx-8">
        <h3>Passenger 1</h3>
      </div>
      <DropDownList
        label={'Number of Passengers'}
        value={passengerCount}
        optionList={[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}
        onChange={handleCountChange}
      />
      <PassengerCard name={'Damika Anupama'} gender={'Male'} age={'23 Years'} location={'Earth, SOL'} />

      {Array.from({ length: passengerCount - 1 }).map((val, index) => (
        <div key={index}>
          <div className="my-8 mx-8">
            <h3>Passenger {index + 2}</h3>
          </div>
          <TextBox text={'Inter Galactic ID'} />
          <TextBox text={'First Name'} />
          <TextBox text={'Last Name'} />
        </div>
      ))}
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default PassengersFragment;
