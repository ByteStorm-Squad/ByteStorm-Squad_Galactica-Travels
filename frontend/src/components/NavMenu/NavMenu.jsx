import React, { useState } from 'react';
import { Home, Person, SpaceDashboard, RocketLaunch, Map, WbSunny } from '@mui/icons-material';
import { Link } from 'react-router-dom';
import './styles.css';
import sun from '../../images/navmenu/sun.png';

const NavMenu = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const toggleMenuOpen = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  return (
    <nav className={isMenuOpen ? 'open bg-black bg-opacity-80' : 'bg-none'}>
      <div className="nav-content">
        <div className="toggle-btn" onClick={toggleMenuOpen}>
          <img src={sun} className="bg-[#FFDC2680] rounded-full w-16" />
        </div>
        <span style={{ '--i': 1 }}>
          <div>
            <Link to="/map" onClick={toggleMenuOpen}>
              <Map />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 2 }}>
          <div>
            <Link to="/journeys" onClick={toggleMenuOpen}>
              <RocketLaunch />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 3 }}>
          <div>
            <Link to="/booking" onClick={toggleMenuOpen}>
              <SpaceDashboard />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 4 }}>
          <div>
            <Link to="/account" onClick={toggleMenuOpen}>
              <Person />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 5 }}>
          <div>
            <Link to="/" onClick={toggleMenuOpen}>
              <Home />
            </Link>
          </div>
        </span>
      </div>
    </nav>
  );
};

export default NavMenu;
