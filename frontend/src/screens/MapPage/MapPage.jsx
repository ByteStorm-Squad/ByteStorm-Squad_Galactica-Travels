import { AnimatePresence } from 'framer-motion';
import Provider from '../../components/Provider/Provider';
import Wrapper from '../../components/Wrapper/Wrapper';
import KeyVisual from '../../components/KeyVisual/KeyVisual';
import PageHeader from '../../components/PageHeader/PageHeader';

const MapPage = () => {
  return (
    <Provider>
      <Wrapper>
        <PageHeader title={'Map'} className="flex justify-center items-center h-10 w-full pl-6 mt-14" />
        <AnimatePresence>
          <KeyVisual />
        </AnimatePresence>
      </Wrapper>
    </Provider>
  );
};

export default MapPage;
