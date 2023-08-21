import React from 'react';
import { ArrowBackIos } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

const PageHeader = ({ title, showBackButton = true, onBackPress, ...otherProps }) => {
  const navigate = useNavigate();

  return (
    <>
      {showBackButton && (
        <button
          onClick={() => (onBackPress ? onBackPress() : navigate(-1))}
          className="absolute top-14 left-8 pl-1 flex h-10 w-12 rounded-md justify-around items-center bg-white bg-opacity-10"
        >
          <ArrowBackIos className="flex justify-center px-1" />
        </button>
      )}
      <div className="flex justify-center items-center h-10 w-full pl-6 my-14" {...otherProps}>
        <h1 className="text-3xl font-semibold">{title}</h1>
      </div>
    </>
  );
};

export default PageHeader;
