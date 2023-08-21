import React from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';

import AttractionsSelector from './AttractionsSelector';
import PopularSelector from './PopularSelector';
import image1 from '../../images/Slider/zephyria.png';
import image2 from '../../images/Slider/img_2.jpg';
import image3 from '../../images/Slider/img_3.jpg';
import image4 from '../../images/Slider/img_1.jpg';
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
    {
      image: image4,
      description:
        "Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.",
    },
  ];

  return (
    <>
      <PageHeader title="Dashboard" showBackButton={false} className="flex justify-center items-center h-10 w-full pl-6 my-14 mb-7" />
      <AttractionsSelector />
      <PopularSelector />
      <div className="text-yellow-500 text-2xl font-medium text-center my-4">Zephyria</div>
      <AttractionSlider components={items} />
      <div className="flex flex-col w-full justify-center items-center gap-1 py-6 mt-4 pb-10 rounded-t-3xl bg-white/10">
        <span className="text-white text-base font-semibold">Travel Modes starting from</span>
        <span className="text-green-500 text-2xl font-semibold">$16,000</span>
        <Button text="Book Now" type="stroke" />
      </div>
    </>
  );
};

export default Dashboard;
