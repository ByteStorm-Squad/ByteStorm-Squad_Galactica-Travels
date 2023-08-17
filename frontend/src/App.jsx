import React from 'react';
import { NavMenu, Hero, Footer, Memory, Explore, Advertise, Pricings, Banner, Newslatter, Background } from './components';
import { hero, navlinks, memory, placesAPI, brands, pricingapi, bannerAPI, footerAPI } from './data/dummy_data';
import { Routes, Route } from 'react-router-dom';
import Dashboard from './screens/Dashboard';
import Account from './screens/Account';
import Booking from './screens/Booking';

const App = () => {
  return (
    <>
      <Background />
      <NavMenu />
      {/* <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/account" element={<Account />} />
        <Route path="/booking" element={<Booking />} />
      </Routes> */}
    </>
  );
};

export default App;
