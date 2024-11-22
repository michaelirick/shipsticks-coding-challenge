import React from 'react';
import {
  ModalHeader,
  ModalContent,
  ModalActions,
  Button,
  Modal,
  Table
} from 'semantic-ui-react';

import { useQuery } from '@tanstack/react-query';
import useCsrf from 'hooks/use_csrf';
import axios from 'axios';

const productQuery = `
  query GetProduct($id: ID!) {
    product(id: $id) {
      id
      name
      type
      length
      width
      height
      weight
      calculatorResults {
        id
        length
        width
        height
        weight
      }
    }
  }
`;

interface SavedResultsModalProps {
  open: boolean;
  setOpen: (open: boolean) => void;
  productId: string;
}

interface Product {
  id: string;
  name: string;
  type: string;
  length: number;
  width: number;
  height: number;
  weight: number;
  calculatorResults: CalculatorResult[];
}

interface CalculatorResult {
  id: string;
  length: number;
  width: number;
  height: number;
  weight: number;
}

const SavedResultsModal: React.FC<SavedResultsModalProps> = ({ open, setOpen, productId }) => {
  const { data } = useQuery<Product>({
    queryKey: ['product', { id: productId }],
    queryFn: async () => {
      return axios.post('/graphql', {
        query: productQuery,
        variables: { id: productId }
      }, {
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': useCsrf()
        }
      }).then((res) => {
        return res.data.data.product;
      });
    }
  });
  
  const onClose = () => {
    setOpen(false);
  }

  return (
    <Modal open={open} onClose={onClose}>
      <ModalHeader>Saved Results{data && data.name && ` for ${data.name}`}</ModalHeader>
      <ModalContent>
        <Table celled>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Length</Table.HeaderCell>
              <Table.HeaderCell>Width</Table.HeaderCell>
              <Table.HeaderCell>Height</Table.HeaderCell>
              <Table.HeaderCell>Weight</Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          <Table.Body>
            {data && data.calculatorResults.length === 0 && (
              <Table.Row key="none">
                <Table.Cell colSpan="4">No saved results</Table.Cell>
              </Table.Row>
            )}
            {data && data.calculatorResults.map((result) => (
              <Table.Row key={result.id}>
                <Table.Cell>{result.length}</Table.Cell>
                <Table.Cell>{result.width}</Table.Cell>
                <Table.Cell>{result.height}</Table.Cell>
                <Table.Cell>{result.weight}</Table.Cell>
              </Table.Row>
            ))}
          </Table.Body>
        </Table>
      </ModalContent>
      <ModalActions>
        <Button onClick={onClose}>Close</Button>
      </ModalActions>
    </Modal>
  );
};

export default SavedResultsModal;