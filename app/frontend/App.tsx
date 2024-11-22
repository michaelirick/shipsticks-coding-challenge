import { FC, useState } from 'react';
import {
  QueryClient,
  QueryClientProvider
} from '@tanstack/react-query';

import Navbar from './components/navbar';
import ProductsList from './pages/products/list';
import CalculatorModal from './pages/calculator/modal';

import 'semantic-ui-css/semantic.min.css';

const queryClient = new QueryClient();

const App: FC = () => {
  const [calculatorOpen, setCalculatorOpen] = useState(false);

  return (
    <QueryClientProvider client={queryClient}>
      <Navbar setCalculatorOpen={setCalculatorOpen} />
      <ProductsList />
      <CalculatorModal open={calculatorOpen} setOpen={setCalculatorOpen} />
    </QueryClientProvider>
)};

export default App;
