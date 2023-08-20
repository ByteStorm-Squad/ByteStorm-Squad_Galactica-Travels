import React from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';
import TextBox from '../../components/TextBox/TextBox';
import Button from '../../components/Button/Button';
import DatePickerSelector from '../../components/DatePicker/DatePickerSelector';
import DropDownList from '../../components/DropDownList/DropDownList';


export const SignupPage = () => {
  const HomeLocations = ['Mercury', 'Venus', 'Earth', 'Mars'];
  return (
    <>
      <PageHeader title="Sign Up" />
      <div className="my-8 mx-8">
        <h1 style={{ fontSize: '1.5rem' }}>SignUp Details</h1>
      </div>
      <TextBox text="First Name*" />
      <TextBox text="Last Name*" />
      <DatePickerSelector label="Date of Birth*"/>
      <TextBox text="Inter Galactic ID" />
      <TextBox text="Contact Identifier" />
      <DropDownList label="Home Location" dropdownlist={HomeLocations}/>
      <div className="flex justify-center">
        <Button text="Submit" type="full" />
      </div>
    </>
  );
};

export default SignupPage;
