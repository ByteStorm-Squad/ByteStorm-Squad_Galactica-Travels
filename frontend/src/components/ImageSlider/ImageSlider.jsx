import React from 'react';
import './ImageSlider.css';
import AliceCarousel from 'react-alice-carousel';
import 'react-alice-carousel/lib/alice-carousel.css';
import image1 from '../../images/Slider/img_1.jpg';
import image2 from '../../images/Slider/img_2.jpg';
import image3 from '../../images/Slider/img_3.jpg';

const ImageSlider = () => {
    const ImageLink=['../../images/Slider/img_1.jpg','../../images/Slider/img_2.jpg',]
  return (
    <div className="App">
    <AliceCarousel animationEasingFunction='fadeout' disableButtonsControls responsive>
      <img
        src={image1}
        className="sliderimg"
        style={{ borderRadius: '90px', margin: '40px', width: '75%', height: '300px' }}
        alt="Image 1"
      />
      <img
        src={image2}
        className="sliderimg"
        style={{ borderRadius: '90px', margin: '40px', width: '75%', height: '300px' }}
        alt="Image 2"
      />
      <img
        src={image3}
        className="sliderimg"
        style={{ borderRadius: '90px', margin: '40px',  width: '75%', height: '300px' }}
        alt="Image 3"
      />
    </AliceCarousel>
  </div>
  
  );
};

export default ImageSlider;
