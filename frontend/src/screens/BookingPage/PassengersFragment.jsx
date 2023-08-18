import React from 'react';
import Button from '../../components/Button/Button';
import TextBox from '../../components/TextBox/TextBox';
import PassengerCard from '../../components/PassengerCard/PassengerCard';

const PassengersFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Passenger Details</h2>
      </div>
      <div className="my-8 mx-8">
        <h3>Passenger 1</h3>
      </div>
      <TextBox text={'Inter Galactic ID'} />
      <PassengerCard name={'Damika Anupama'} gender={'Male'} age={'23 Years'} location={'Earth, SOL'} />
      <div className="my-8 mx-8">
        <h3>Passenger 2</h3>
      </div>

      <TextBox text={'Inter Galactic ID'} />
      <TextBox text={'First Name'} />
      <TextBox text={'Last Name'} />

      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default PassengersFragment;
