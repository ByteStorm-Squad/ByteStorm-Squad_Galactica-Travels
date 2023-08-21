import React, { useState } from 'react';
import { Check } from '@mui/icons-material';

const PaymentCard = ({ paymentMethods, selectedMethod, setSelectedMethod }) => {
  return (
    <div className="flex flex-col justify-center items-center my-2 mx-4 py-2 rounded-xl bg-white/10">
      {paymentMethods.map(paymentMethod => (
        <div className="flex justify-start items-center gap-5 text-lg font-bold px-5 py-2 w-80 bg-black/30 rounded-xl my-1">
          <img src={paymentMethod.img} className="w-12 rounded-xl" />
          <h4 style={{ fontFamily: 'Arial, sans-serif', fontWeight: 'normal' }}>{paymentMethod.name}</h4>
          <div
            onClick={() => setSelectedMethod(paymentMethod.name)}
            className={`flex justify-center items-center ml-auto rounded-3xl w-8 h-8  ${
              selectedMethod === paymentMethod.name ? 'bg-green-600 text-white' : 'bg-white/80 text-transparent'
            }`}
          >
            <Check fontSize="12" />
          </div>
        </div>
      ))}
    </div>
  );
};

export default PaymentCard;
