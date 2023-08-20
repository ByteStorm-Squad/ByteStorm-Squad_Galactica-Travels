import React from 'react';

const ImageContainer = ({ imageurl,width,height }) => {
  const containerStyle = {
    display: 'flex',
    justifyContent: 'center', // Center horizontally
    alignItems: 'center', // Center vertically
    padding: '20px', // Add padding of 10px
  };

  const imageStyle = {
    borderRadius: '15%', // Rounded corners
    width: width, // Set the width as needed
    height: height, // Set the height as needed
  };

  return (
    <div className="flex flex-col justify-center items-center mx-4 my-4 rounded-xl overflow-hidden bg-white/20">
      <div style={containerStyle}>
        <img src={imageurl} style={imageStyle} alt="Image" />
      </div>
    </div>
  );
};

export default ImageContainer;
