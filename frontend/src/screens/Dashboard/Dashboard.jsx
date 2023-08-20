import React from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';

import AttractionsSelector from './AttractionsSelector';
import PopularSelector from './PopularSelector';
import image1 from '../../images/Slider/img_1.jpg';
import image2 from '../../images/Slider/img_2.jpg';
import image3 from '../../images/Slider/img_3.jpg';
import AttractionSlider from './AttractionSlider';
import Button from '../../components/Button/Button';

const Dashboard = () => {
  const items = [
    {
      image: image1,
      description:
        "Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.",
    },
    {
      image: image2,
      description:
        "Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.",
    },
    {
      image: image3,
      description:
        "Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.",
    },
  ];

  return (
    <>
      <PageHeader title="Dashboard" showBackButton={false} />
      <AttractionsSelector />
      <PopularSelector />
      <div className="text-yellow-500 text-2xl font-medium text-center">Zephyria</div>
      <AttractionSlider components={items} />
      <div className="flex flex-col w-full justify-center items-center gap-2 py-2 bg-white/10">
        <span className="text-white text-base font-semibold">Travel Modes starting from</span>
        <span className="text-green-500 text-2xl font-semibold">$16,000</span>
        <Button text="Book Now" type="stroke" />
      </div>
    </>
  );
};

export default Dashboard;
