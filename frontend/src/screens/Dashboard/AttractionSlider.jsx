import React, { useState } from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';

import 'swiper/css';
import 'swiper/css/effect-coverflow';
import 'swiper/css/bundle';
import 'swiper/css/pagination';
import 'swiper/css/navigation';

import { Pagination, Navigation, EffectCoverflow, Scrollbar, A11y } from 'swiper/modules';
import AttractionSlide from './AttractionSlide';

const AttractionSlider = ({ components }) => {
  const [activeSlide, setActiveSlide] = useState(0);

  const handleSlideChange = swiper => {
    setActiveSlide(swiper.realIndex); // Update the active slide index
  };

  return (
    <div className="bg-white/10">
      <Swiper
        modules={[EffectCoverflow, Pagination, Navigation, A11y, Scrollbar]}
        effect={'coverflow'}
        grabCursor={true}
        centeredSlides={true}
        loop={true}
        slidesPerView={'auto'}
        coverflowEffect={{
          rotate: 0,
          stretch: 10,
          depth: 100,
          modifier: 2.5,
        }}
        pagination={{ el: '.swiper-pagination', clickable: true }}
        navigation={{
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
          clickable: true,
        }}
        onSlideChange={handleSlideChange}
      >
        {components.map((item, index) => (
          <SwiperSlide
            key={index}
            style={{
              height: '440px',
              width: '250px',
              display: 'flex',
              justifyContent: 'center',
              alignItems: 'center',
              margin: '20px',
            }}
          >
            <AttractionSlide
              tag={item.tag}
              tagColor={item.tagColor}
              image={item.image}
              title={item.title}
              description={item.description}
              showDescription={activeSlide == index}
            />
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  );
};
export default AttractionSlider;
