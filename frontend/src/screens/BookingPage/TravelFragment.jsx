import React from 'react';
import Button from '../../components/Button/Button';
import TextBox from '../../components/TextBox/TextBox';

const TravelFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Travel Details</h2>
      </div>
      <div className="my-8 mx-8 text-gray-300">
        <h3>Pod Selection (Passenger 1)</h3>
      </div>
      <TextBox text={'Class'} />
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default TravelFragment;
