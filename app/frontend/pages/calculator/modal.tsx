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
import { useMutation } from '@tanstack/react-query';
import useCsrf from 'hooks/use_csrf';
import axios from 'axios';
import SelectedProduct from './selected_product';

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

const CalculatorModal = ({ open, setOpen }) => {
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [enteredDimensions, setEnteredDimensions] = useState(null);
  const mutation = useMutation({
    mutationFn: (dimensions) => {
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
    onSuccess: (data, variables, context) => {
      setSelectedProduct(data.data.data.closestProduct);
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
            <CalculatorForm onSubmit={mutation} />
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