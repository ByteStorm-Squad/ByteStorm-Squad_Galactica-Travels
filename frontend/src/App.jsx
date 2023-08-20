import React from 'react';
import { NavMenu, Background } from './components';
import { Routes, Route } from 'react-router-dom';
import Dashboard from './screens/Dashboard/Dashboard';
import AccountPage from './screens/AccountPage/AccountPage';
import BookingPage from './screens/BookingPage/BookingPage';
import { SignupPage2 } from './screens/SignupPage2/SignupPage2';
import JourneysPage from './screens/JourneysPage/JourneysPage';
import MapPage from './screens/MapPage/MapPage';
import Profile from './screens/Profile/Profile';
import Explorepage from './screens/ExplorePage/ExplorePage';
import SignupPage from './screens/SignupPage/SignupPage';

const App = () => {
  return (
    <>
      <Background />
      <NavMenu />
      <Routes>
        <Route path="/" element={<SignupPage />} />
        <Route path="/account" element={<Profile />} />
        <Route path="/booking" element={<BookingPage />} />
        <Route path="/journeys" element={<JourneysPage />} />
        <Route path="/map" element={<MapPage />} />
        <Route path="/explore" element={<Explorepage />} />
        {/* <Route path="/dashboard" element={<Dashboard />} /> */}
        <Route path="/signup" element={<SignupPage />} />
        <Route path="/signup2" element={<SignupPage2 />} />
      </Routes>
    </>
  );
};

export default App;
