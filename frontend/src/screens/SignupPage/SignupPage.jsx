import React from 'react';
import { CalendarMonth } from '../../icons/CalendarMonth/CalendarMonth';
import PageHeader from '../../components/PageHeader/PageHeader';
import TextBox from '../../components/TextBox/TextBox';
import DateField from '../../components/DateField/DateField';

export const SignupPage = () => {
  return (
    <>
      <PageHeader title="Sign Up" />
      <div className="my-8 mx-8">
        <h2>Signup Details</h2>
      </div>
      <TextBox text={'First Name *'} />
      <TextBox text={'Last Name *'} />
      <DateField text={'Date of Birth *'} />
      <TextBox text={'Inter Galactic ID'} />
      <TextBox text={'Contact Identifier'} />
      <TextBox text={'Home Location'} />
    </>
  );
};

export default CalendarMonth;
