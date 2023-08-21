import React from 'react';
import Button from '../../components/Button/Button';
import TextBox from '../../components/TextBox/TextBox';
import SeatPicker from '../../components/SeatPicker/SeatPicker';
import DropDownList from '../../components/DropDownList/DropDownList';

const TravelFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Travel Details</h2>
      </div>
      <div className="my-8 mx-8 text-gray-300">
        <h3>Passenger 1</h3>
      </div>
      <DropDownList label={'Travel Class'} dropdownlist={['Platinum Member', 'Gold Member']} />
      <SeatPicker />
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default TravelFragment;
