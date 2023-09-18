import React from 'react';
import './Button.css';

export const Button = ({ type, text = 'Button text', onClick, ...otherProps }) => {
  return (
    <button className={`button ${type}`} onClick={onClick} {...otherProps}>
      <div>{text}</div>
    </button>
  );
};

export default Button;
