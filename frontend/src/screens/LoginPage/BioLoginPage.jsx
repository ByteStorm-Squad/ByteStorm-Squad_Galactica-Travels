import React from 'react';
import { useState } from 'react';
import Arrow from '../../images/Arrow2.png';
import PageHeader from '../../components/PageHeader/PageHeader';
import ComponentSlider from '../../components/ComponentSlider/ComponentSlider';
import { WindupChildren } from 'windups';

import img1 from '../../images/Slider/Google.png';
import img2 from '../../images/Slider/Insta.png';
import img3 from '../../images/Slider/Facebook.png';
import img4 from '../../images/Slider/Twitter.png';
import FaceDetector from '../../components/FaceDetector/FaceDetector';

const BioLoginPage = () => {
  const items = [
    <div style={{ backgroundColor: 'white', width: 200, padding: 20, borderRadius: 10 }}>
      <img src={img1} style={{ height: 100, width: 150 }} />
      <h1 style={{ marginLeft: 55 }}>Google</h1>
    </div>,
    <div style={{ backgroundColor: 'white', width: 200, padding: 20, borderRadius: 10 }}>
      <img src={img2} style={{ height: 100, width: 150 }} />
      <h1 style={{ marginLeft: 55 }}>Instagram</h1>
    </div>,
    <div style={{ backgroundColor: 'white', width: 200, padding: 20, borderRadius: 10 }}>
      <img src={img3} style={{ height: 100, width: 150 }} />
      <h1 style={{ marginLeft: 55 }}>Facebook</h1>
    </div>,
    <div style={{ backgroundColor: 'white', width: 200, padding: 20, borderRadius: 10 }}>
      <img src={img4} style={{ height: 100, width: 150 }} />
      <h1 style={{ marginLeft: 55 }}>Twitter</h1>
    </div>,
  ];

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [iscorrect, setIscorrect] = useState(false);
  const [isLogged, setIsLogged] = useState(false);
  const handleLogin = () => {
    if (iscorrect && password === '1234') {
      setIsLogged(true);
      console.log('login success');
    } else if (!iscorrect && email === 'amila') {
      setIscorrect(true);
    }
  };

  return (
    <>
      <PageHeader title={'Login'} />
      <div className="flex justify-center items-center p-10 mx-5 rounded-3xl h-[300px]  bg-white/10">
        <FaceDetector />
      </div>
      <div>Biometric Verification</div>
    </>
  );
};

export default BioLoginPage;
