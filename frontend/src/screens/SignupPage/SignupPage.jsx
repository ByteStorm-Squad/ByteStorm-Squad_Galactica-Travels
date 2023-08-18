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
    <div className="signup-page">
      <div className="overlap-group-wrapper">
        <div className="overlap-group">
          <div className="text-wrapper">SignUp</div>
          <div className="div">SignUp Details</div>
          <div className="component">
            <TextBox className="input-text-here" text="First Name*" type="text" />
            <div className="text-field-details">0/20</div>
          </div>
          <div className="component-2">
            <TextBox className="input-text-here" text="Contact Identifier" type="text" />
            <div className="text-field-details">0/20</div>
          </div>
          <div className="component-3">
            <TextBox className="input-text-here" text="Last Name*" type="text" />
            <div className="text-field-details">0/20</div>
          </div>
          <div className="overlap">
           
              <Box sx={{ minWidth: 240 }}>
                {' '}
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
              <div className="text-field-details">0/20</div>
            {/* <CalendarMonth className="calendar-month" /> */}
          </div>
          <div className="component-5">
            <TextBox className="input-text-here" text="Inter Galactic ID" type="text" />
            <div className="text-field-details">0/20</div>
          </div>
          <div className="overlap-2">
            <div className="component-6">
              <Box sx={{ minWidth: 120 }}>
                <FormControl fullWidth>
                  <InputLabel
                    id="demo-simple-select-label"
                    sx={{ color: 'rgb(181, 164, 164)' }} // Set the input label color to white
                  >
                    Home Location
                  </InputLabel>
                  <Select
                    labelId="demo-simple-select-label"
                    id="demo-simple-select"
                    label="Age"
                    sx={{ color: 'rgb(181, 164, 164)' }} // Set the font color to white
                  >
                    <MenuItem value={10}>Location 1</MenuItem>
                    <MenuItem value={20}>Location 2</MenuItem>
                    <MenuItem value={30}>Location 3</MenuItem>
                  </Select>
                </FormControl>
              </Box>
              <div className="text-field-details">0/20</div>
            </div>
            <img
              className="arrow"
              alt="Arrow"
              src="https://generation-sessions.s3.amazonaws.com/3bcb445300c22561c34e152b4a4056d5/img/arrow-3.svg"
            />
          </div>
          <Button className="button-instance" divClassName="design-component-instance-node" text="Submit" type="full" />

          <img
            className="chevron-left"
            alt="Chevron left"
            src="https://generation-sessions.s3.amazonaws.com/3bcb445300c22561c34e152b4a4056d5/img/chevron-left.svg"
          />
        </div>
      </div>
    </div>
  );
};

export default CalendarMonth;
