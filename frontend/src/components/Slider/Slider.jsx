import React from 'react';
import { Swiper, SwiperSlide } from 'swiper/react';

import 'swiper/css';
import 'swiper/css/effect-coverflow';
import 'swiper/css/bundle';
import 'swiper/css/pagination';
import 'swiper/css/navigation';

import { Pagination, Navigation, EffectCoverflow, Scrollbar, A11y } from 'swiper/modules';





const SliderComponent = ({ components }) => {
  

  return (
    <div style={{ width: 450, marginLeft: 30, height: 400 }}>
      <h1>______________________or_____________________</h1>
      <div style={{ marginTop: 40 }}>
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
          className="swiper_container"
        >
            {components.map((item,index) => (
                <SwiperSlide key = {index} style={{ height: 300, width: 300 }}>{item}</SwiperSlide>
            ))}
        </Swiper>
      </div>
    </div>
  );
};
export default SliderComponent;
