import React from 'react';
import { CircularProgressbar, buildStyles } from 'react-circular-progressbar';

const UserCard = ({ name, percentage, age, gender }) => {
  return (
    <div className="flex justify-start h-[150px] m-5 mt-10 p-7 rounded-3xl bg-white/10">
      <CircularProgressbar
        value={percentage}
        text={`${percentage}%`}
        styles={buildStyles({
          pathTransitionDuration: 1,
          pathColor: percentage > 60 ? '#24922f' : '#D7D000',
          textColor: 'white',
        })}
      />

      <div className="flex flex-col gap-2 w-[250px]">
        {percentage > 90 ? (
          <>
            <span>{name}</span>
            <span>Age: {age}</span>
            <span>Gender: {gender}</span>
          </>
        ) : (
          <>
            <span className="text-red-400 text-center mr-8">Verification</span>
            <span className="text-red-400 text-center mr-8">Percentage</span>
            <span className="text-red-400 text-center mr-8">Too Low</span>
          </>
        )}
      </div>
    </div>
  );
};

export default UserCard;
