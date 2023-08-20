import React from 'react';

const AttractionsSelector = () => {
  const containerStyle = {
    backgroundColor: '#212020',
    border: '1px solid',
    borderColor: '#aab810',
    borderRadius: '32px',
    boxShadow: 'inset 0px 4px 4px #00000040',
    height: '35px',
    width: '120px',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  };
  return (
    <div className="w-full flex flex-grow justify-evenly mb-8">
      <div style={containerStyle}>
        <div className="text-white text-base font-semibold left-0 tracking-normal">Events</div>
      </div>
      <div style={containerStyle}>
        <div className="text-white text-base font-semibold left-0 tracking-normal">Attractions</div>
      </div>
      <div style={containerStyle}>
        <div className="text-white text-base font-semibold left-0 tracking-normal">Cultures</div>
      </div>
    </div>
  );
};

export default AttractionsSelector;
