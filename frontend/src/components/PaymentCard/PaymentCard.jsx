import { Check } from '@mui/icons-material';
import AddCircleOutlineSharpIcon from '@mui/icons-material/AddCircleOutlineSharp';
import React from 'react';

const PaymentCard = ({url1,url2,text1,text2,isNeeded}) => {
  return (
    <div className="flex flex-col justify-center items-center my-2 mx-4 rounded-xl h-50 w-100 overflow-hidden bg-white/10">     
      <div className="flex justify-center items-center gap-2 text-lg font-bold h-12 w-80 bg-black/30 rounded-xl my-2">
        <img src={url1} width="30px" height="20px"/>
        <h4 style={{ fontFamily: 'Arial, sans-serif', fontWeight: 'normal' }}>{text1}</h4>
        <div className="flex justify-center items-center rounded-3xl w-8 h-8 bg-green-600 text-white">
          <Check fontSize="12" />
        </div>       
      </div>
      <div className="flex justify-center items-center gap-2 text-lg font-bold h-12 w-80 bg-black/50 rounded-xl my-2">
        <img src={url2} width="30px" height="20px"/>
        <h4 style={{ fontFamily: 'Arial, sans-serif', fontWeight: 'normal' }}>{text2}</h4>
        <div className="flex justify-center items-center rounded-3xl w-8 h-8 bg-white/30 text-white">                 
        </div>       
      </div>
      <div className="flex justify-center items-center gap-2 text-lg font-bold w-80  rounded-xl my-4">
      <AddCircleOutlineSharpIcon fontSize="12"/><h4 style={{ fontFamily: 'Arial, sans-serif', fontWeight: 'normal' }}>Add New Card</h4>
      </div>
    </div>
  );
};

export default PaymentCard;
