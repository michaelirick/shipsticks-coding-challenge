import { FC } from 'react';
import { Container, Table, Header } from 'semantic-ui-react';
import { useQuery } from '@tanstack/react-query';

import axios from 'axios';
import useCsrf from 'hooks/use_csrf';

const productsQuery = `
  query GetAllProducts($type: String, $limit: Int, $offset: Int) {
    products(type: $type, limit: $limit, offset: $offset) {
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

const ProductsList: FC = () => {
  const { isPending, error, data } = useQuery({
    queryKey: ['products'],
    queryFn: async () => {
      return axios.post('/graphql', {
        query: productsQuery,
        variables: {
          limit: 10,
          offset: 0
        }
      }, {
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': useCsrf()
        }
      }).then((res) => res.data.data.products);
    }
  });

  return (
    <Container>
      <Header as='h1'>Products</Header>
      <Table celled>
        <Table.Header>
          <Table.Row>
            <Table.HeaderCell>Name</Table.HeaderCell>
            <Table.HeaderCell>Type</Table.HeaderCell>
            <Table.HeaderCell>Length</Table.HeaderCell>
            <Table.HeaderCell>Width</Table.HeaderCell>
            <Table.HeaderCell>Height</Table.HeaderCell>
            <Table.HeaderCell>Weight</Table.HeaderCell>
          </Table.Row>
        </Table.Header>
        <Table.Body>
          {isPending && (
            <Table.Row>
              <Table.Cell colSpan="6">Loading...</Table.Cell>
              </Table.Row>
              )}
          {data?.map((product) => (
            <Table.Row key={product.id}>
              <Table.Cell>{product.name}</Table.Cell>
              <Table.Cell>{product.type}</Table.Cell>
              <Table.Cell>{product.length}</Table.Cell>
              <Table.Cell>{product.width}</Table.Cell>
              <Table.Cell>{product.height}</Table.Cell>
              <Table.Cell>{product.weight}</Table.Cell>
            </Table.Row>
          ))}
        </Table.Body>
      </Table>
    </Container>
  );
};

export default ProductsList;