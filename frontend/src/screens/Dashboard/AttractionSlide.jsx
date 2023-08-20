import React from 'react';

const AttractionSlide = ({ image, description, showDescription = true }) => {
  const imgStyle = {
    borderRadius: '25px',
    height: '200px',
    width: '200px',
    border: '3px solid',
    borderColor: '#ffbc10',
    marginBottom: '20px',
  };
  const textStyleVisible = {
    WebkitTextStroke: '0.5px #ffbc10',
    fontFamily: '"PT Bold Arch-Regular", Helvetica',
    color: '#ffffff',
    fontSize: '15px',
    fontWeight: 600,
    textAlign: 'center',
    width: '100%',
    opacity: 1,
    transition: 'opacity 0.3s ease',
  };

  const textStyleHidden = {
    WebkitTextStroke: '0.5px #ffbc10',
    fontFamily: '"PT Bold Arch-Regular", Helvetica',
    color: '#ffffff',
    fontSize: '15px',
    fontWeight: 600,
    textAlign: 'center',
    width: '100%',
    opacity: 0,
    transition: 'opacity 0.4s ease',
  };

  return (
    <div className="flex flex-col items-center justify-center">
      <img src={image} style={imgStyle} alt="Image" />
      <div style={showDescription ? textStyleVisible : textStyleHidden}>{description}</div>
    </div>
  );
};

export default AttractionSlide;
