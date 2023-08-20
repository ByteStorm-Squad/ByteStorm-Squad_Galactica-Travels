import React from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';

import AttractionsSelector from './AttractionsSelector';
import PopularSelector from './PopularSelector';
import image1 from '../../images/Slider/img_1.jpg';
import image2 from '../../images/Slider/img_2.jpg';
import image3 from '../../images/Slider/img_3.jpg';
import ComponentSlider from '../../components/ComponentSlider/ComponentSlider';

const Dashboard = () => {
  const items = [
    <div>
      <img src={image1} style={{ borderRadius: '90px', height: 250, width: 250 }} alt="Image 1" />
      <div>Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.</div>
    </div>,
    <div>
      <img src={image2} style={{ borderRadius: '90px', height: 250, width: 250 }} alt="Image 2" />
      <div>Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.</div>
    </div>,
    <div>
      <img src={image3} style={{ borderRadius: '90px', height: 250, width: 250 }} alt="Image 3" />
      <div>Explore Zephyria's Enchanted Arboretum: A mesmerizing fusion of flora and fauna, painting an intergalactic masterpiece.</div>
    </div>,
  ];
  return (
    <>
      <PageHeader title="Dashboard" showBackButton={false} />
      <AttractionsSelector />
      <PopularSelector />
      <div className="text-yellow-500 text-2xl font-medium text-center">Zephyria</div>
      <ComponentSlider components={items} />
    </>
  );
};

export default Dashboard;
