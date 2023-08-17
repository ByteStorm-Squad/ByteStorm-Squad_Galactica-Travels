import React, { useState } from 'react';
import { Home, Person, SpaceDashboard, RocketLaunch, Map, WbSunny } from '@mui/icons-material';
import './styles.css';
import { Link } from 'react-router-dom';

const NavMenu = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <nav className={isMenuOpen ? 'open' : 'close'}>
      <div className="nav-content">
        <div className="toggle-btn" onClick={() => setIsMenuOpen(!isMenuOpen)}>
          <WbSunny />
        </div>
        <span style={{ '--i': 1 }}>
          <div>
            <Link to="/map">
              <Map />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 2 }}>
          <div>
            <Link to="/journeys">
              <RocketLaunch />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 3 }}>
          <div>
            <Link to="/booking">
              <SpaceDashboard />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 4 }}>
          <div>
            <Link to="/account">
              <Person />
            </Link>
          </div>
        </span>
        <span style={{ '--i': 5 }}>
          <div>
            <Link to="/">
              <Home />
            </Link>
          </div>
        </span>
      </div>
    </nav>
  );
};

export default NavMenu;
