import React from 'react';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';

const DropDownList = ({ label, value, optionList, onChange }) => {
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
    color: '#888',
    fontSize: '15px',
    outline: 'none', // Remove default focus outline
  };

  return (
    <div className="mx-8 my-5">
      <div style={rectangleStyle}>
        <FormControl fullWidth style={labelStyle}>
          <InputLabel id="demo-simple-select-label" style={labelStyle}>
            {label}
          </InputLabel>
          <Select
            labelId="demo-simple-select-label"
            id="demo-simple-select"
            sx={{
              color: '#ffffff',
              '&.MuiOutlinedInput-root': {
                '& fieldset': {
                  borderColor: 'transparent',
                },
                '&:hover fieldset': {
                  borderColor: 'transparent',
                },
                '&.Mui-focused fieldset': {
                  borderColor: 'transparent',
                },
              },
            }}
            value={value}
            onChange={onChange}
          >
            {optionList.map(option => (
              <MenuItem key={option} value={option}>
                {option}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
      </div>
    </div>
  );
};

export default DropDownList;
