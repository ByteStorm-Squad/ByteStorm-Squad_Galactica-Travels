import PropTypes from "prop-types";
import React from "react";
import "./Button.css";

export const Button = ({ type, className, divClassName, text = "Button text" }) => {
  return (
    <div className={`button ${type} ${className}`}>
      <button type="button" className={`button-button ${divClassName}`}>
        <div className={`button-text ${divClassName}`}>{text}</div>
      </button>
    </div>
  );
};

Button.propTypes = {
  type: PropTypes.oneOf(["full", "stroke", "none", "full-disabled"]),
  text: PropTypes.string,
};

export default Button;
