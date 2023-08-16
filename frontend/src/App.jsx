import React from 'react';
import { NavMenu, Hero, Footer, Memory, Explore, Advertise, Pricings, Banner, Newslatter, Background } from './components';
import { hero, navlinks, memory, placesAPI, brands, pricingapi, bannerAPI, footerAPI } from './data/travigodata';
import TextBox from '../src/components/TextBox/TextBox';

const App = () => {
  return (
    <>
      <Background />
      <TextBox text="First Name*"/>
      {/* <NavMenu navlinks={navlinks} />
      <Memory memory={memory} />
      <Explore title="Explore The Beauty of World" placesAPI={placesAPI} />
      <Advertise brands={brands} />
      <Pricings pricingapi={pricingapi} />
      <Banner bannerAPI={bannerAPI} />
      <Newslatter />
      <Footer footerAPI={footerAPI} /> */}
    </>
  );
};

export default App;
