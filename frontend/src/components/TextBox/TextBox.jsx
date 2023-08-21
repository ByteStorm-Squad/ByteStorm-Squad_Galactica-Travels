import React, { useState } from 'react';

const TextBox = props => {
  const { text, type, outerClassName = 'mx-8 my-5', onChange, ownerState, inputProps, InputProps, error, ...otherProps } = props;

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
  };

  return (
    <div className={outerClassName}>
      <div style={rectangleStyle}>
        <input type={type} onChange={onChange} placeholder={text} style={inputStyle} {...otherProps} />
      </div>
    </div>
  );
};

export default TextBox;
