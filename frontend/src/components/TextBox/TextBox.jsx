import React, { useState } from 'react';

const TextBox = ({ text, type }) => {
  const [inputValue, setInputValue] = useState(''); // State to store the input value

  const handleInputChange = event => {
    setInputValue(event.target.value); // Update the input value
  };

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

  const inputStyle = {
    flex: 1, // Allow the input to take remaining width
    border: 'none',
    background: 'transparent',
    color: 'white',
    fontSize: '15px',
    outline: 'none', // Remove default focus outline
    padding: '9px'
  };

  return (
    <div className="mx-8 my-5">
      <div style={rectangleStyle}>
        <input type={type} value={inputValue} onChange={handleInputChange} placeholder={text} style={inputStyle} />
      </div>
      <div className="flex justify-end text-gray-400">
        <p>0/20</p>
      </div>
    </div>
  );
};

export default TextBox;
