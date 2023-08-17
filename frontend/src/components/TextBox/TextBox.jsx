import React, { useState } from "react";

const Box = ({ text ,type}) => {
  const [inputValue, setInputValue] = useState(""); // State to store the input value

  const handleInputChange = (event) => {
    setInputValue(event.target.value); // Update the input value
  };

  const rectangleStyle = {
    backgroundColor: "#1c1c1d",
    borderBottomStyle: "solid",
    borderBottomWidth: "2px",
    borderColor: "transparent",
    borderImage: "linear-gradient(to bottom, rgb(255, 152.77, 0), rgb(95.88, 91.8, 96.89)) 1",
    borderRadius: "12px",
    height: "52px",
    left: "0",
    top: "0",
    width: "370px",
    display: "flex", // Display the input and button side by side
    alignItems: "center", // Center content vertically
    padding: "0 10px", // Add padding for better spacing
  };

  const inputStyle = {
    flex: 1, // Allow the input to take remaining width
    border: "none",
    background: "transparent",
    color: "white",
    fontSize: "15px",
    outline: "none", // Remove default focus outline
  };

  return (
    <div className="rectangle" style={rectangleStyle}>
      <input
        type={type}
        value={inputValue}
        onChange={handleInputChange}
        placeholder={text}
        style={inputStyle}
      />
    </div>
  );
};

export default Box;
