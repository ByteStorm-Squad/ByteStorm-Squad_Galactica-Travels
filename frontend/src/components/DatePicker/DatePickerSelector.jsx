import React, { useState } from 'react';
import { CalendarMonth } from '../../icons/CalendarMonth/CalendarMonth';
import { DemoContainer } from '@mui/x-date-pickers/internals/demo';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';

const DatePickerSelector = ({label}) => {  
  const rectangleStyle = {
    backgroundColor: '#1c1c1d',
    borderBottomWidth: '2px',
    borderRadius: '12px',
    borderColor: '#FF9900',
    height: '45px',
    width: '100%',
    display: 'flex', // Display the input and button side by side
    alignItems: 'center', // Center content vertically
    padding: '0 10px', // Add padding for better spacing
  }; 
  const labelStyle = {
    flex: 1, // Allow the input to take remaining width
    border: 'none',
    background: 'transparent',
    color: 'text-gray-400',
    fontSize: '15px',
    outline: 'none', // Remove default focus outline
  };
  const customStyles = {
    input: {
      color: '#888', // Light gray color
      width: '100%',
    },
    label: {
      color: '#888', // Light gray color
    },
  };

  return (
    <div className="mx-8 my-5">
      <div style={rectangleStyle}>
        <LocalizationProvider dateAdapter={AdapterDayjs} className="input-text-here">
          <DemoContainer components={['DatePicker']} >
            <div style={{ width: '100%' }}> {/* Adjust container width */}
              <DatePicker
                label={label}
                style={labelStyle}
                sx={{
                  '& .MuiInputBase-input': {
                    color: '#888',
                    width: '100%', // Match the width of the container
                  },
                  '& .MuiInputLabel-root': {
                    color: '#888',
                    border: '1px solid transparent', // Transparent border
                  },
                  // Add more custom styles as needed
                }}
              />
            </div>
          </DemoContainer>
        </LocalizationProvider>
      </div>
      <div className="flex justify-end text-gray-400">
        <p>0/20</p>
      </div>
    </div>
  );
};

export default DatePickerSelector;
