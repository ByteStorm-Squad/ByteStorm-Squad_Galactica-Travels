import React from 'react';
import './Button.css';

export const Button = ({ type, text = 'Button text', onClick }) => {
  return (
    <button className={`button ${type}`} onClick={onClick}>
      <div>{text}</div>
    </button>
  );
};

export default Button;
