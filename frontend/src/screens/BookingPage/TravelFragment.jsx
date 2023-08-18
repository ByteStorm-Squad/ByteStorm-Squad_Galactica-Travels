import React from 'react';
import Button from '../../components/Button/Button';
import TextBox from '../../components/TextBox/TextBox';

const TravelFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Travel Details</h2>
      </div>
      <TextBox text={'Travel Mode'} />
      <TextBox text={'Travelling Document Type'} />
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default TravelFragment;
