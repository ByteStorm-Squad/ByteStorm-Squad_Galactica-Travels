import React from 'react';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import { ArrowLeftOutlined, ArrowRightOutlined, CalendarMonth } from '@mui/icons-material';

const DateField = ({ text }) => {
  const rectangleStyle = {
    backgroundColor: '#1c1c1d',
    borderBottomWidth: '2px',
    borderRadius: '12px',
    borderColor: '#FF9900',
    height: '45px',
    width: '100%',
    display: 'flex',
    alignItems: 'center',
    padding: '0 10px',
  };

  const inputStyle = {
    flex: 1,
    border: 'none',
    background: 'transparent',
    color: 'white',
    fontSize: '15px',
    outline: 'none',
    width: '100%',
    padding: '6px 12px',
  };

  const popperSx = {
    '& .MuiPaper-root': {
      backgroundColor: 'rgba(120, 120, 120, 0.2)',
    },
    '& .MuiCalendarPicker-root': {
      backgroundColor: 'rgba(45, 85, 255, 0.4)',
    },
    '& .MuiPickersDay-dayWithMargin': {
      color: 'rgb(229,228,226)',
      backgroundColor: 'rgba(50, 136, 153)',
    },
    '& .MuiTabs-root': { backgroundColor: 'rgba(120, 120, 120, 0.4)' },
  };

  const inputSx = { '& .MuiInputBase-root': { backgroundColor: 'blue' } };

  return (
    <div className="mx-8 my-5">
      <DatePicker
        label={text}
        slots={{
          OpenPickerIcon: CalendarMonth,
        }}
        PopperProps={{
          sx: popperSx,
        }}
        InputProps={{ sx: inputSx }}
      />
    </div>
  );
};

export default DateField;
