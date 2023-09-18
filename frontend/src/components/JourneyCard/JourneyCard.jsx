import { ArrowForwardIos, RocketLaunch } from '@mui/icons-material';
import React from 'react';

const JourneyCard = ({ spaceship, journeyCode, departure, arrival, onClick }) => {
  return (
    <div className="flex flex-col justify-center items-center mx-8 my-8 rounded-xl overflow-hidden bg-white/20">
      <div className="flex justify-center items-center text-lg font-bold h-12 w-full bg-black/50">
        <h3>{spaceship}</h3>
      </div>
      <div className="flex justify-center items-center gap-5 h-28">
        <div className="flex flex-col justify-center items-center">
          <div>DEP : MIL</div>
          <div className="my-2">
            <RocketLaunch />
          </div>
          <div>DES : TRI</div>
        </div>
        <div className="flex flex-col grow gap-2 text-gray-300 text-xs">
          <div>Departure : {departure}</div>
          <div>Arrival : {arrival}</div>
        </div>
      </div>
      <div className="flex justify-center items-center gap-2 text-lg font-bold h-14 w-full bg-black/50" onClick={onClick}>
        <h3>Book Journey {journeyCode}</h3>
        <div className="flex justify-center items-center rounded-3xl w-8 h-8 bg-green-600 text-white">
          <ArrowForwardIos fontSize="12" />
        </div>
      </div>
    </div>
  );
};

export default JourneyCard;
