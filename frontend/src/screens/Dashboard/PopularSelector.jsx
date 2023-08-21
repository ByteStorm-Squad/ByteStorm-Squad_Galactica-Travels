import React from 'react';

const PopularSelector = () => {
  const containerStyle = {
    backgroundColor: '#24922f',
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
    <div className="w-full flex flex-grow justify-evenly">
      {/* <div style={containerStyle}>
        <div className="text-white text-sm font-semibold left-0 tracking-normal">Upcoming</div>
      </div> */}
      <div style={containerStyle}>
        <div className="text-white text-sm font-semibold left-0 tracking-normal">Popular</div>
      </div>
      {/* <div style={containerStyle}>
        <div className="text-white text-sm font-semibold left-0 tracking-normal">Highly Rated</div>
      </div> */}
    </div>
  );
};

export default PopularSelector;
