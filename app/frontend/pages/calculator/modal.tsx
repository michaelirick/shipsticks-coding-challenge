import React, { useState } from 'react';
import {
  ModalHeader,
  ModalDescription,
  ModalContent,
  ModalActions,
  Button,
  Header,
  Modal
} from 'semantic-ui-react';
import CalculatorForm from './form';
import { useMutation, UseMutateFunction } from '@tanstack/react-query';
import useCsrf from 'hooks/use_csrf';
import axios, { AxiosResponse } from 'axios';
import SelectedProduct from './selected_product';
import Errors from 'components/errors';

const closestProductQuery = `
  query GetClosestProduct($length: Int!, $width: Int!, $height: Int!, $weight: Int!) {
    closestProduct(length: $length, width: $width, height: $height, weight: $weight) {
      id
      name
      type
      length
      width
      height
      weight
    }
  }
`;

interface CalculatorModalProps {
  open: boolean;
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
}

interface Dimensions {
  length: number;
  width: number;
  height: number;
  weight: number;
}

interface Product {
  id: string;
  name: string;
  type: string;
  length: number;
  width: number;
  height: number;
  weight: number;
}

const CalculatorModal: React.FC<CalculatorModalProps> = ({ open, setOpen }) => {
  const [selectedProduct, setSelectedProduct] = useState<Product | null>(null);
  const [enteredDimensions, setEnteredDimensions] = useState<Dimensions | null>(null);
  const [errors, setErrors] = useState<Record<string, string> | null>(null);

  const mutation = useMutation<AxiosResponse<any>, Error, Dimensions>({
    mutationFn: (dimensions: Dimensions) => {
      setEnteredDimensions(dimensions);
      return axios.post('/graphql', {
        query: closestProductQuery,
        variables: dimensions
      },
        {
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': useCsrf()
          }
        }
      )
    },
    onSuccess: (data) => {
      if(data.data.data.closestProduct === null) {
        setErrors({ product: 'No matching product found' });
        return;
      }
      setSelectedProduct(data.data.data.closestProduct);
    },
    onError: (error) => {
      console.log('error', error);
    }
  });

  const onClose = () => {
    setSelectedProduct(null);
    mutation.reset();
    setOpen(false);
  }

  return (
    <Modal open={open} onClose={onClose}>
      <ModalHeader>Calculator</ModalHeader>
      <ModalContent>
        
        {selectedProduct ? (
          <ModalDescription>
            <SelectedProduct {...selectedProduct} dimensions={enteredDimensions} />
          </ModalDescription>
        ) : mutation.isPending ? <p>Loading...</p> : (
          <>
            <ModalDescription>
              <Header as="h3">How to use the calculator</Header>
              <p>
                Enter the length, width, and height of the item you want to ship, and the weight of the item. The calculator will then provide you with the most closely matching product.
              </p>
            </ModalDescription>          
            <CalculatorForm onSubmit={mutation.mutate as UseMutateFunction<AxiosResponse<any>, Error, Dimensions>} />
            {errors && <Errors errors={errors} />}
          </>
        ) }
      </ModalContent>
      <ModalActions>
        <Button onClick={onClose}>Close</Button>
      </ModalActions>
    </Modal>
  );
};

export default CalculatorModal;