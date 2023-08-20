import React from 'react';
import Button from '../../components/Button/Button';
import TextBox from '../../components/TextBox/TextBox';
import ImageSlider from '../../components/ImageSlider/ImageSlider';
import SeatPicker from '../../components/SeatPicker/SeatPicker';

const TravelFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Travel Details</h2>
      </div>
      <div className="my-8 mx-8 text-gray-300">
        <h3>Passenger 1</h3>
      </div>
      <TextBox text={'Travel Class'} />
      <SeatPicker />
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default TravelFragment;
