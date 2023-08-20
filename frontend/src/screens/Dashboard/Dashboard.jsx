import React from 'react';
import LoginPage from '../LoginPage/loginPage';

import Union from '../../images/union.svg';
import MainImage from '../../images/zephyria.png';
import Button from '../../components/Button/Button';

import './style.css';
import PageHeader from '../../components/PageHeader/PageHeader';

const Dashboard = () => {
  return (
    <>
      <PageHeader title="Dashboard" showBackButton={false} />
      <div className="dashboard">
        <div className="overlap">
          <div className="frame">
            <div className="group">
              <div className="overlap-group">
                <div className="popular-now">Upcoming</div>
              </div>
            </div>
            <div className="group">
              <div className="overlap-group">
                <div className="popular-now">Popular</div>
              </div>
            </div>
            <div className="overlap-group-wrapper">
              <div className="overlap-group">
                <div className="popular-now">Highly Rated</div>
              </div>
            </div>
          </div>
          <div className="frame-2">
            <div className="group-2">
              <div className="div-wrapper">
                <div className="text-wrapper-2">Events</div>
              </div>
            </div>
            <div className="group-2">
              <div className="div-wrapper">
                <div className="popular-destinations">Attractions</div>
              </div>
            </div>
            <div className="group-3">
              <div className="div-wrapper">
                <div className="unique-cultures">Cultures</div>
              </div>
            </div>
          </div>
          <div className="rectangle-wrapper">
            <div className="rectangle" />
          </div>
          <img className="union" alt="Union" src={Union} />
          {/* add a button that goes to booking page */}

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
          </div>
        </div>
      </div>
    </>
  );
};

export default Dashboard;
