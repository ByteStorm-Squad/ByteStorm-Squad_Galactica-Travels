import React from 'react';
import {useState} from 'react';
import Typed from 'react-typed';
import Arrow from '../../images/Arrow2.png';
import PageHeader from "../../components/PageHeader/PageHeader";
import SliderComponent from '../../components/Slider/Slider';


import img1 from '../../images/Slider/Google.png';
import img2 from '../../images/Slider/Insta.png';
import img3 from '../../images/Slider/Facebook.png';
import img4 from '../../images/Slider/Twitter.png';

const LoginPage = () => {


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
    if(iscorrect && password === '1234'){
        setIsLogged(true);
        console.log('login success');
    }
    else if(!iscorrect && email === 'amila'){
        setIscorrect(true);
    }
  }
 
  return (
    <div>
      <PageHeader title={'Login'}/>
      <div style={{justifyContent:'center',padding:40,backgroundColor:'white',opacity:0.8,margin:6,borderRadius:10}}>
        <Typed strings={['Welcome to the Intergalactic Travelling', 'Explore the Universe']} typeSpeed={60} backSpeed={60} F loop />

        <h1 style={{color:'white',marginTop:10}}>Enter the your mail:</h1>
        <div style={{display:'flex',flexDirection:'row',marginBottom:10}}>
            <img src={Arrow} style={{width:30,height:20,color:'white',marginTop:8,display : iscorrect?'none' : 'block'}}/>
            <input type="text" style={{borderColor:'white',width:300,height:40}} onChange={(e) => setEmail(e.target.value)}/>
        </div>

        <h4 style={{color:'white',display : iscorrect?'flex' : 'none'}}>Enter the Passwors</h4>
        <div style={{flexDirection:'row',display : iscorrect?'flex' : 'none'}}>
            <img src={Arrow} style={{width:30,height:20,color:'white',marginTop:8,display:isLogged?'none':'block'}}/>
            <input type="text" style={{borderColor:'white',width:300,height:40}} onChange={(e) => setPassword(e.target.value)}/>
        </div>

        <button style={{backgroundColor:'white',opacity:0.8,marginLeft:60,marginTop:15,padding:10,borderWidth:2,borderColor:'white',borderRadius:8,width:200}} onClick={handleLogin}>Continue</button>
        
      </div>

      <hr style={{backgroundColor:'white'}}></hr>

      <SliderComponent components={items}/>
    </div>
  );
};

export default LoginPage;
