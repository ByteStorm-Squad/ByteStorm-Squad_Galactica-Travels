import React from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';
import TextBox from '../../components/TextBox/TextBox';
import Button from '../../components/Button/Button';
import DropDownList from '../../components/DropDownList/DropDownList';
import DateField from '../../components/DateField/DateField';
import { registerUser } from '../../hooks/Login/loginApi';

export const SignupPage = () => {
  const Galaxy = ['Andromeda', 'Milky Way', 'Centaurus A', 'Orion'];
  const GenderList = ['Male', 'Female', 'Other'];

  const [selectedFirstName, setSelectedFirstName] = React.useState('');
  const [selectedLastName, setSelectedLastName] = React.useState('');
  const [selectedEmail, setSelectedEmail] = React.useState('');
  const [selectedPassword, setSelectedPassword] = React.useState('');
  const [selectedGender, setSelectedGender] = React.useState('Male');
  const [selectedDOB, setSelectedDOB] = React.useState('08/20/2023');
  const [selectedIGID, setSelectedIGID] = React.useState('');
  const [selectedContactID, setSelectedContactID] = React.useState('');
  const [selectedGalaxy, setSelectedGalaxy] = React.useState('Andromeda');

  const handleSignUp = async () => {
    const userDetails = {
      first_name: selectedFirstName,
      last_name: selectedLastName,
      password: selectedPassword,
      dob: selectedDOB,
      gender: selectedGender,
      email: selectedEmail,
      intergalactic_id: selectedIGID,
      contactID: selectedContactID,
      mobile: "123-456-7890",
      user_type: "General",
      address: "123 Main St",
      galaxy: selectedGalaxy,
      solar_system: "Solar System",
      spacecraft: "Spaceship 1",
      display_photo: "url_to_image"
    };

    // Reset the input value
    setSelectedFirstName('')
    setSelectedLastName('')
    setSelectedEmail('')
    setSelectedPassword('')
    setSelectedGender('')
    setSelectedDOB('')
    setSelectedIGID('')
    setSelectedContactID('')
    setSelectedGalaxy('')

    try {
      await registerUser(userDetails);
    } catch (error) {
      console.error('Error sending user data:', error);
    }
  };


  return (
    <>
      <PageHeader title="Sign Up" />
      <div className="my-8 mx-8">
        <h1 style={{ fontSize: '1.5rem' }}>SignUp Details</h1>
      </div>
      <TextBox text="First Name*" value={selectedFirstName} onChange={(e) => setSelectedFirstName(e.target.value)} />
      <TextBox text="Last Name*" value={selectedLastName} onChange={(e) => setSelectedLastName(e.target.value)} />
      <TextBox text="Email*" value={selectedEmail} onChange={(e) => setSelectedEmail(e.target.value)} />
      <TextBox type="password" text="Password*" value={selectedPassword} onChange={(e) => setSelectedPassword(e.target.value)} />
      <DropDownList label="Gender" dropdownlist={GenderList} value={selectedGender} onChange={(e) => setSelectedGender(e.target.value)} />
      <DateField text={'Date of Birth *'} value={selectedDOB} onChange={(e) => setSelectedDOB(e.target.value)} />
      <TextBox text="Inter Galactic ID" value={selectedIGID} onChange={(e) => setSelectedIGID(e.target.value)} />
      <TextBox text="Contact Identifier" value={selectedContactID} onChange={(e) => setSelectedContactID(e.target.value)} />
      <DropDownList label="Home Location" dropdownlist={Galaxy} value={selectedGalaxy} onChange={(e) => setSelectedGalaxy(e.target.value)} />
      <div className="flex justify-center">
        <Button text="Submit" type="full" onClick={handleSignUp} method="POST" />
      </div>
    </>
  );
};



export default SignupPage;
