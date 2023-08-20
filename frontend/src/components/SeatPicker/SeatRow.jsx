import React from 'react';
import Seat from './Seat';

export default function SeatRow({ rowNum, rowMap, setSelectedSeat, selectedSeat }) {
  return (
    <ol className="row fuselage">
      {Object.keys(rowMap).map(letter => {
        const seatID = rowNum + letter;
        return (
          <li key={seatID}>
            <Seat seatID={seatID} setSelectedSeat={setSelectedSeat} isSelected={selectedSeat === seatID} occupied={rowMap[letter]} />
          </li>
        );
      })}
    </ol>
  );
}
