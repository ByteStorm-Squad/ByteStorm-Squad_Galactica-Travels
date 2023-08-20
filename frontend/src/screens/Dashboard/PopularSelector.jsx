import React from 'react';

const PopularSelector = () => {
  const container = {
    backgroundColor: '#24922f',
    borderRadius: '32px',
    boxShadow: 'inset 0px 4px 4px #00000040',
    height: '26px',
    position: relative,
    width: '120px',
    display: flex,
    alignItems: center,
    justifyContent: center,
  };
  return (
    <div className="w-full flex flex-grow justify-evenly">
      <div style={container}>
        <div className="popular-now">Upcoming</div>
      </div>
      <div style={container}>
        <div className="popular-now">Popular</div>
      </div>
      <div style={container}>
        <div className="popular-now">Highly Rated</div>
      </div>
    </div>
  );
};

export default PopularSelector;
