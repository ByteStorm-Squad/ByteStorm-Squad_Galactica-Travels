import { Check } from '@mui/icons-material';
import React from 'react';
import img1 from '../../images/img1.webp';

const PassengerCard = ({ name, gender, age, location }) => {
  return (
    <div className="flex flex-col justify-center items-center mx-8 my-2 rounded-xl overflow-hidden bg-white/20">
      <div className="flex justify-center items-center gap-3 h-28 w-full">
        <div className="flex justify-start items-center w-28">
          <img src={img1} />
        </div>
        <div className="flex flex-col grow gap-2 text-gray-300 text-xs">
          <div>{name}</div>
          <div>{gender}</div>
          <div>{age}</div>
          <div>{location}</div>
        </div>
      </div>
      <div className="flex justify-center items-center gap-2 text-lg font-bold h-14 w-full bg-black/50">
        <div className="flex justify-center items-center rounded-3xl w-8 h-8 bg-green-600 text-white">
          <Check fontSize="12" />
        </div>
        <h3>Verified Successfully</h3>
      </div>
    </div>
  );
};

export default PassengerCard;
