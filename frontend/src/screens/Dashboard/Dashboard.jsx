import React from 'react';
import LoginPage from '../LoginPage/loginPage';

import Union from '../../images/union.svg';
import MainImage from '../../images/zephyria.png';
import Button from '../../components/Button/Button';
import PageHeader from '../../components/PageHeader/PageHeader';

import AttractionsSelector from './AttractionsSelector';
import PopularSelector from './PopularSelector';

const Dashboard = () => {
  return (
    <>
      <PageHeader title="Dashboard" showBackButton={false} />
      <AttractionsSelector />
      <PopularSelector />
      {/* 
      <div className="rectangle-wrapper">
        <div className="rectangle" />
      </div>
      <img className="union" alt="Union" src={Union} />
      <div className="flexcontainer">
        <p className="text">
          <span className="span">
            Distance&nbsp;&nbsp;: 1.87 Light Years
            <br />
          </span>
        </p>
        <p className="text">
          <span className="text-wrapper-4">
            Travel Modes starting from
            <br />
          </span>
        </p>
        <p className="text">
          <span className="text-wrapper-5">$16000</span>
          <span className="text-wrapper-6">&nbsp;</span>
        </p>
        <Button text="Book Now" type="full" onClick={() => {}} />
      </div>
      <div className="text-wrapper-7">Zephyria</div>
      <div className="group-4">
        <div className="overlap-2">
          <div className="frame-3">
            <div className="rectangle-2" />
          </div>

          <div className="group-5">
            <div className="overlap-group-2">
              <div className="main-image">
                <img className="rectangle-4" alt="Rectangle" src={MainImage} />
              </div>
            </div>
          </div>
        </div>
        <p className="explore-zephyria-s">
          Explore Zephyria&#39;s Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.
        </p>
      </div>{' '}
      */}
    </>
  );
};

export default Dashboard;
