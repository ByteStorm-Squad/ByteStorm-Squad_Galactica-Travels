import React from 'react';
import { CircularProgressbar, buildStyles } from 'react-circular-progressbar';
import { PieChart, Pie } from 'recharts';
import 'react-circular-progressbar/dist/styles.css';
import Chart from 'react-google-charts';

export const SkillCard = ({ title, percentage, color, style }) => {
  const defaultStyles = {
    backgroundColor: '#333333',
    opacity: 0.66,
    borderRadius: 6,
    height: 140,
    width: 120,
    padding: 10,
  };
  return (
    <div style={{ ...defaultStyles, ...style }}>
      <div style={{ width: 100, height: 100 }}>
        <CircularProgressbar
          value={percentage}
          text={`${percentage}%`}
          styles={buildStyles({
            pathTransitionDuration: 0.5,
            pathColor: color,
            textColor: 'white',
          })}
        />
      </div>

      <p style={{ textAlign: 'center', color: 'white' }}>{title}</p>
    </div>
  );
};

export const DetailCard = ({ title, detail, ishilighted, style }) => {
  const defaultStyles = {
    padding: 20,
    backgroundColor: '#333333',
    opacity: 0.66,
    borderRadius: 6,
    maxWidth: 200,
    maxHeight: 100,
    borderWidth: 2,
    borderStyle: 'solid',
    borderColor: ishilighted ? '#D7D000' : 'black',
  };
  return (
    <div style={{ ...defaultStyles, ...style }}>
      <p style={{ color: 'white' }}>
        {title} : {detail}
      </p>
    </div>
  );
};



export const DonutChart = ({height,width,data}) => {

  const options = {
    pieHole: 0.85,
    is3D: false,
    legend: 'none',
    backgroundColor: 'transparent',
    pieSliceText: 'none',
    colors: ["#06007F", "#2C7F00"],
  };

  return (
    <div>
      <Chart chartType="PieChart" width={width} height={height} data={data} options={options} />
    </div>
  );
};
