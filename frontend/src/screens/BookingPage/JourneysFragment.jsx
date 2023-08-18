import React from 'react';
import Button from '../../components/Button/Button';

const JourneysFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Available Journeys</h2>
      </div>
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default JourneysFragment;
