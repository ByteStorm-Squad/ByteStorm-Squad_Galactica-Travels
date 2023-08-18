import React from 'react';
import Button from '../../components/Button/Button';
import { CalendarMonth } from '../../icons/CalendarMonth/CalendarMonth';
import TextBox from '../../components/TextBox/TextBox';
import './SignupPage.css';
import DatePicker from 'react-datepicker';

export const SignupPage = () => {
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
            <div className="component-4">
              <div className="input-text-here">Date of Birth *</div>
              <div className="text-field-details">0/20</div>
            </div>
            <CalendarMonth className="calendar-month" />
          </div>
          <div className="component-5">
            <TextBox className="input-text-here" text="Inter Galactic ID" type="text" />
            <div className="text-field-details">0/20</div>
          </div>
          <div className="overlap-2">
            <div className="component-6">
              <div className="input-text-here">Home Location</div>
              <div className="text-field-details">0/20</div>
            </div>
            <img
              className="arrow"
              alt="Arrow"
              src="https://generation-sessions.s3.amazonaws.com/3bcb445300c22561c34e152b4a4056d5/img/arrow-3.svg"
            />
          </div>
          <Button text="Submit" type="full" />
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
