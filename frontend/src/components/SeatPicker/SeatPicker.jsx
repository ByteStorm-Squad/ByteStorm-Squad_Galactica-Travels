/*global WebviewSdk */
import React, { useState } from 'react';
import SeatRow from './SeatRow';
import './styles.css';

const seatMap = {};
for (let i = 0; i < 10; i++) {
  ['A', 'B', 'C', 'D', 'E', 'F'].forEach(letter => {
    if (seatMap[i]) {
      seatMap[i][letter] = Math.random() < 0.3;
    } else {
      seatMap[i] = { [letter]: Math.random() < 0.3 };
    }
  });
}
export default function SeatPicker() {
  const [selectedSeat, setSelectedSeat] = useState(null);

  return (
    <div className="plane">
      <div className="cockpit" />
      <div className="exit exit--front fuselage" />
      {Object.keys(seatMap).map(rowNum => (
        <SeatRow key={rowNum} rowNum={rowNum} rowMap={seatMap[rowNum]} setSelectedSeat={setSelectedSeat} selectedSeat={selectedSeat} />
      ))}
    </div>
  );
}
