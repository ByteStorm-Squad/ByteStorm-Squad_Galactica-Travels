import React from 'react';
import cx from 'classnames';

export default function Seat({ seatID, occupied, setSelectedSeat, isSelected }) {
  return (
    <label className="seat">
      <span
        id={seatID}
        className={cx({
          occupied,
          selected: isSelected,
        })}
        onClick={() => {
          if (occupied) {
            return;
          }
          if (isSelected) {
            setSelectedSeat(null);
            return;
          }
          setSelectedSeat(seatID);
        }}
      >
        {seatID}
      </span>
    </label>
  );
}
