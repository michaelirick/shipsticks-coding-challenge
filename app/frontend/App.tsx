import { FC } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import {
  QueryClient,
  QueryClientProvider
} from '@tanstack/react-query';

import Navbar from './components/navbar';
import ProductsList from './pages/products/list';

import 'semantic-ui-css/semantic.min.css';


const Home: FC = () => {
  return (
    <div>
      <h1>Home</h1>
    </div>
)}



const queryClient = new QueryClient();

const App: FC = () => {
  return (
    <QueryClientProvider client={queryClient}>
      <Router>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/products" element={<ProductsList />} />
        </Routes>
      </Router>
    </QueryClientProvider>
)};

export default App;
