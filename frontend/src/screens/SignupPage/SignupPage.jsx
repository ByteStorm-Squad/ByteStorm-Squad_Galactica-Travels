import React from 'react';
import { CalendarMonth } from '../../icons/CalendarMonth/CalendarMonth';
import { DemoContainer } from '@mui/x-date-pickers/internals/demo';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import Box from '@mui/material/Box';

export const SignupPage = () => {
  return (
    <>
      <Box sx={{ minWidth: 240 }}>
        {/* Doubling the width by adjusting minWidth */}
        <LocalizationProvider dateAdapter={AdapterDayjs} className="input-text-here">
          <DemoContainer components={['DatePicker']}>
            <DatePicker
              label="Date of Birth*"
              sx={{
                '& .MuiInputBase-input': {
                  color: 'white',
                },
                '& .MuiInputBase-root': {
                  backgroundColor: '#333',
                },
                '& .MuiInputLabel-root': {
                  color: 'white',
                },
                width: '200%', // Doubling the width
                // Add more custom styles as needed
              }}
            />
          </DemoContainer>
        </LocalizationProvider>
      </Box>
    </>
  );
};

export default CalendarMonth;
