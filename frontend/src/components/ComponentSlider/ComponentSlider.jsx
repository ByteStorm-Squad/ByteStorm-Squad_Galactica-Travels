import React from 'react';
import './ComponentSlider.css';
import AliceCarousel from 'react-alice-carousel';
import 'react-alice-carousel/lib/alice-carousel.css';


const ComponentSlider = ({ComponentListUrl}) => {
  const ComponentList = ComponentListUrl;
  return (
    <div className="App">
      <AliceCarousel animationEasingFunction="fadeout" disableButtonsControls responsive>
      {ComponentList.map((ComponentSrc, index) => (
        ComponentSrc
      ))}
      </AliceCarousel>
    </div>
  );
};

export default ComponentSlider;
