import React from 'react';
import { Button } from '../../components/Button/Button';
import { CalendarMonth } from '../../icons/CalendarMonth/CalendarMonth';
import TextBox from '../../components/TextBox/TextBox';
import './SignupPage.css';
import { DemoContainer } from '@mui/x-date-pickers/internals/demo';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import Box from '@mui/material/Box';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

export const SignupPage = () => {
  const minDate = new Date(new Date().getFullYear(), new Date().getMonth(), 7, 0, 0, 0);
  const maxDate = new Date(
    new Date().getFullYear(),
    new Date().getMonth(),
    27,
    new Date().getHours(),
    new Date().getMinutes(),
    new Date().getSeconds(),
  );
  const dateValue = new Date(new Date().setDate(14));
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
