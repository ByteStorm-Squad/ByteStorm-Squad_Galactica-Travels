import React from 'react';
import { ArrowLeftOutlined, ArrowRightOutlined, CalendarMonth } from '@mui/icons-material';
import TextBox from '../TextBox/TextBox';
import { DatePicker, LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';

const DateField = ({ text }) => {
  return (
    <LocalizationProvider dateAdapter={AdapterDayjs}>
      <DatePicker label={text} slots={{ textField: TextBox }} slotProps={{ textField: { placeholder: text } }} />
    </LocalizationProvider>
  );
};

export default DateField;
