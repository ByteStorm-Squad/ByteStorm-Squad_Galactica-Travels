import React from 'react';
import Button from '../../components/Button/Button';

const PaymentFragment = ({ incrementFragmentNo }) => {
  return (
    <>
      <div className="my-8 mx-8">
        <h2>Payment Details</h2>
      </div>
      <div className="flex justify-center">
        <Button text="Continue" type="full" onClick={incrementFragmentNo} />
      </div>
    </>
  );
};

export default PaymentFragment;
