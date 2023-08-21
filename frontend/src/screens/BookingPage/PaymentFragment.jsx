import React from 'react';
import Button from '../../components/Button/Button';
import PaymentCard from '../../components/PaymentCard/PaymentCard';

const PaymentFragment = ({ incrementFragmentNo }) => {
  const BankList = [
    {
      icon: 'https://banner2.cleanpng.com/20180802/xri/kisspng-logo-mastercard-vector-graphics-font-visa-mastercard-logo-png-photo-png-arts-5b634298cd58d5.9008352515332317688411.jpg',
      text: 'MasterCard Credit/Debit Card',
    },
    {
      icon: 'https://w7.pngwing.com/pngs/618/512/png-transparent-visa-logo-mastercard-credit-card-payment-visa-blue-company-text.png',
      text: 'Visa Credit/Debit Card',
    },
  ];
  return (
    <>
      <div className="my-8 mx-8">
        <h2 style={{ fontSize: '24px' }}>Payment Details</h2>
      </div>
      <div className="my-8 mx-8">
        <h6>Classic Methods</h6>
      </div>
      <PaymentCard
        url1="https://banner2.cleanpng.com/20180802/xri/kisspng-logo-mastercard-vector-graphics-font-visa-mastercard-logo-png-photo-png-arts-5b634298cd58d5.9008352515332317688411.jpg"
        url2="https://w7.pngwing.com/pngs/618/512/png-transparent-visa-logo-mastercard-credit-card-payment-visa-blue-company-text.png"
        text1="MasterCard Credit/Debit Card"
        text2="Visa Credit/Debit Card"
        isNeeded="true"
      />
      <div className="my-8 mx-8">
        <h4>Modern Methods</h4>
      </div>
      <PaymentCard
        url1="https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png"
        url2="data:image/png;base64,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"
        text1="Bitcoin Payment"
        text2="Inter Galactic Coins"
        isNeeded="true"
      />
      <div className="my-8 mx-8 flex justify-between items-center">
        <div>
          <div className="my-8 mx-8 flex justify-between items-center">
            <div>
              <h1 className="text-1xl">Total</h1>
              <h1 className="text-3xl">3000$</h1>
            </div>
            <Button text="Proceed to Payment" type="full" onClick={incrementFragmentNo} />
          </div>
        </div>
        <Button text="Proceed to Payment" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default PaymentFragment;
