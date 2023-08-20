import React from 'react';
import TextBox from '../../components/TextBox/TextBox';
import Button from '../../components/Button/Button';

const InitialFragment = ({ incrementFragmentNo }) => {
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
