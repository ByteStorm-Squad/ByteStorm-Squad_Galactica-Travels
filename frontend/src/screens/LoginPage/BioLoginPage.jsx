import React from 'react';
import { useState } from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';

import FaceDetector from '../../components/FaceDetector/FaceDetector';
import UserCard from './UserCard';
import Button from '../../components/Button/Button';

const BioLoginPage = () => {
  const [detected, setDetected] = useState(0);

  return (
    <>
      <PageHeader title={'Login'} />
      <div className="flex justify-center items-center p-10 mx-5 rounded-3xl h-[300px]  bg-white/10">
        <FaceDetector setDetected={setDetected} />
      </div>
      <div className="text-white text-3xl font-semibold text-center my-3">Biometric Verification</div>
      <UserCard name="Damika Anupama" age="23" gender="Male" percentage={(detected * 100).toFixed(0)} />
      <div className="flex justify-center items-center p-10 mx-5 my-10 rounded-3xl h-[50px]  bg-white/10">
        <Button text="Other Login Methods" type="stroke" />
      </div>
    </>
  );
};

export default BioLoginPage;
