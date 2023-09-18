import React from 'react';
import PageHeader from '../../components/PageHeader/PageHeader';
import AttractionsSelector from './AttractionsSelector';
import image1 from '../../images/Slider/zephyria.png';
import image2 from '../../images/Slider/img_2.jpg';
import image3 from '../../images/Slider/img_3.jpg';
import image4 from '../../images/Slider/img_1.jpg';
import image5 from '../../images/Slider/img_4.jpg';
import image6 from '../../images/Slider/img_5.jpg';
import AttractionSlider from './AttractionSlider';
import Button from '../../components/Button/Button';
import { Link } from 'react-router-dom';

const Dashboard = () => {
  const items = [
    {
      image: image1,
      title: 'Zephyria',
      description: 'Glowing nebula hub with starlight festivals, attracting stargazers from across galaxies.',
      tag: 'Popular',
      tagColor: '#FF5733',
    },
    {
      image: image2,
      title: 'Etherealis',
      description: 'Floating city on cosmic clouds, a trade nexus for rare artifacts and technologies.',
      tag: 'Upcoming',
      tagColor: '#33FFA8',
    },
    {
      image: image3,
      title: 'AquariPrime',
      description: 'Planetwide ocean oasis known for luminescent marine life and underwater festivals.',
      tag: 'Featured',
      tagColor: '#3366FF',
    },
    {
      image: image4,
      title: 'Celestis Nexus',
      description: 'Grand celestial library at the crossroads of knowledge, drawing scholars from galaxies.',
      tag: 'Recommended',
      tagColor: '#FF33B2',
    },
    {
      image: image5,
      title: 'Aurorium',
      description: 'Vibrant realm of dancing lights, where auroras paint the sky in mesmerizing colors.',
      tag: 'Exotic',
      tagColor: '#FFD933',
    },
    {
      image: image6,
      title: 'Xylophus',
      description: 'Enchanted forest planet with harmonious flora, offering tranquil retreats and nature sanctuaries.',
      tag: 'Nature',
      tagColor: '#33C7FF',
    },
  ];

  return (
    <>
      <PageHeader title="Dashboard" showBackButton={false} className="flex justify-center items-center h-10 w-full pl-6 my-14 mb-7" />
      <AttractionsSelector />
      <AttractionSlider components={items} />
      <div className="flex flex-col w-full justify-center items-center gap-1 py-6 mt-4 pb-10 rounded-t-[30p] bg-white/10">
        <span className="text-white text-base font-semibold">Travel Modes starting from</span>
        <span className="text-green-500 text-2xl font-semibold">$16,000</span>
        <Link to="/booking">
          <Button text="Book Now" type="stroke" />
        </Link>
      </div>
    </>
  );
};

export default Dashboard;
