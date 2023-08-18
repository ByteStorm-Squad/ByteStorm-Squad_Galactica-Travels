import React from 'react';

const PageIndicator = ({ pageNo = 0 }) => {
  return (
    <div className="flex w-full h-2 align-middle justify-center gap-4">
      <div className={pageNo === 0 ? 'w-10 h-2 rounded-sm bg-[#FF9900]' : 'w-10 h-2 rounded-sm bg-white'}></div>
      <div className={pageNo === 1 ? 'w-10 h-2 rounded-sm bg-[#FF9900]' : 'w-10 h-2 rounded-sm bg-white'}></div>
      <div className={pageNo === 2 ? 'w-10 h-2 rounded-sm bg-[#FF9900]' : 'w-10 h-2 rounded-sm bg-white'}></div>
      <div className={pageNo === 3 ? 'w-10 h-2 rounded-sm bg-[#FF9900]' : 'w-10 h-2 rounded-sm bg-white'}></div>
      <div className={pageNo === 4 ? 'w-10 h-2 rounded-sm bg-[#FF9900]' : 'w-10 h-2 rounded-sm bg-white'}></div>
    </div>
  );
};

export default PageIndicator;
