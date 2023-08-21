import React from 'react';
import { useState } from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';
import ComponentSlider from '../../components/ComponentSlider/ComponentSlider';

import img1 from '../../images/Slider/Google.png';
import img2 from '../../images/Slider/Insta.png';
import img3 from '../../images/Slider/Facebook.png';
import img4 from '../../images/Slider/Microsoft.png';
import TextBox from '../../components/TextBox/TextBox';
import Button from '../../components/Button/Button';
import { Link } from 'react-router-dom';

const LoginPage = () => {
  const containerClasses = 'flex flex-col justify-center items-center bg-none p-6 rounded-3xl';
  const items = [
    <div className={containerClasses}>
      <img src={img1} className="w-[120px] mb-2" />
      <h1>Google</h1>
    </div>,
    <div className={containerClasses}>
      <img src={img2} className="w-[120px] mb-2" />
      <h1>Instagram</h1>
    </div>,
    <div className={containerClasses}>
      <img src={img3} className="w-[120px] mb-2" />
      <h1>Facebook</h1>
    </div>,
    <div className={containerClasses}>
      <img src={img4} className="w-[120px] mb-2" />
      <h1>Microsoft</h1>
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
    <div>
      <PageHeader title={'Login'} />
      <div className="text-white text-3xl font-semibold text-center mb-8">Alternative Verification</div>
      <div className="flex flex-col justify-center items-center gap-5 mx-5 mb-10 rounded-3xl h-[300px] bg-white/10">
        <TextBox text="Email*" type="email" outerClassName="w-[90%]" />
        <TextBox text="Password*" type="password" outerClassName="w-[90%]" />
        <Link to="/">
          <Button text="Login" type="stroke" />
        </Link>
        <Link to="/signup">
          <span className="underline">Create new Account</span>
        </Link>
      </div>
      <hr style={{ backgroundColor: 'white' }}></hr>

      <ComponentSlider components={items} className="bg-white/10" />
    </div>
  );
};

export default LoginPage;
