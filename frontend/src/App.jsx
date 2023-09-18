import React from 'react';
import { NavMenu, Background } from './components';
import { Routes, Route } from 'react-router-dom';
import Dashboard from './screens/Dashboard/Dashboard';
import BookingPage from './screens/BookingPage/BookingPage';
import JourneysPage from './screens/JourneysPage/JourneysPage';
import MapPage from './screens/MapPage/MapPage';
import Profile from './screens/Profile/Profile';
import Explorepage from './screens/ExplorePage/ExplorePage';
import SignupPage from './screens/SignupPage/SignupPage';
import BioLoginPage from './screens/LoginPage/BioLoginPage';
import LoginPage from './screens/LoginPage/LoginPage';

const App = () => {
  return (
    <>
      <Background />
      <NavMenu />
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/account" element={<Profile />} />
        <Route path="/booking" element={<BookingPage />} />
        <Route path="/journeys" element={<JourneysPage />} />
        <Route path="/map" element={<MapPage />} />
        <Route path="/explore" element={<Explorepage />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/biologin" element={<BioLoginPage />} />
        <Route path="/login" element={<LoginPage />} />
      </Routes>
    </>
  );
};

export default App;
