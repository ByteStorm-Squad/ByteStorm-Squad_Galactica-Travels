import React, { useState } from 'react';
import { Home, Person, SpaceDashboard, RocketLaunch, Map, WbSunny } from '@mui/icons-material';
import './styles.css';

const NavMenu = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <nav className={isMenuOpen ? 'open' : 'close'}>
      <div className="nav-content">
        <div className="toggle-btn" onClick={() => setIsMenuOpen(!isMenuOpen)}>
          <WbSunny />
        </div>
        <span style={{ '--i': 1 }}>
          <a href="#">
            <Map />
          </a>
        </span>
        <span style={{ '--i': 2 }}>
          <a href="#">
            <RocketLaunch />
          </a>
        </span>
        <span style={{ '--i': 3 }}>
          <a href="#">
            <SpaceDashboard />
          </a>
        </span>
        <span style={{ '--i': 4 }}>
          <a href="#">
            <Person />
          </a>
        </span>
        <span style={{ '--i': 5 }}>
          <a href="#">
            <Home />
          </a>
        </span>
      </div>
    </nav>
  );
};

export default NavMenu;
