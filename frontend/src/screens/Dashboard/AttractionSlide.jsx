import React from 'react';

const AttractionSlide = ({ image, tag, tagColor, title, description, showDescription = true }) => {
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
    color: '#ffffff',
    fontSize: '14px',
    fontWeight: 400,
    textAlign: 'center',
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
    opacity: 0,
    transition: 'opacity 0.4s ease',
  };
  const containerStyle = {
    backgroundColor: tagColor,
    borderRadius: '32px',
    boxShadow: 'inset 0px 4px 4px #00000040',
    height: '26px',
    position: 'relative',
    width: '120px',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  };

  return (
    <div className="flex flex-col items-center justify-center">
      <div style={containerStyle}>
        <div className="text-white text-sm font-semibold left-0 tracking-normal">{tag}</div>
      </div>
      <div className="text-yellow-500 text-2xl font-medium text-center my-4">{title}</div>
      <img src={image} style={imgStyle} alt="Image" />
      <div style={showDescription ? textStyleVisible : textStyleHidden}>{description}</div>
    </div>
  );
};

export default AttractionSlide;
