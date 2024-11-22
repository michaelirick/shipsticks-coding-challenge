import React from "react";
import {
  Item,
  ItemGroup,
  Button,
  Icon
} from "semantic-ui-react";

import { useMutation } from "@tanstack/react-query";
import axios from "axios";
import useCsrf from "hooks/use_csrf";
import Errors from "components/errors";

const calculatorResultSaveQuery = `
  mutation CalculatorResultSave($input: CalculatorResultSaveInput!) {
    calculatorResultSave(input: $input) {
      calculatorResult {
        id
        length
        width
        height
        weight
        product {
          id
          name
        }
      }
    }
  }
`;

interface SelectedProductProps {
  id: string;
  name: string;
  type: string;
  length: number;
  width: number;
  height: number;
  weight: number;
  dimensions: {
    length: number;
    width: number;
    height: number;
    weight: number;
  };
}

const SelectedProduct: React.FC<SelectedProductProps> = ({ id, name, type, length, width, height, weight, dimensions }) => {
  const [errors, setErrors] = React.useState<Record<string, string>>({});
  const mutation = useMutation({
    mutationFn: () => {
      return axios.post('/graphql', {
        query: calculatorResultSaveQuery,
        variables: {
          input: {
            length: dimensions.length,
            width: dimensions.width,
            height: dimensions.height,
            weight: dimensions.weight,
            productId: id
          }
        }
      },
        {
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': useCsrf()
          }
        }
      )
    },
    onError: (error: any) => {
      setErrors(error.response.data.errors[0].extensions);
    }
  });

  return (
    <ItemGroup>
      <Item>
        <Item.Content>
          <Item.Header>Use this {name}</Item.Header>
          <Item.Meta>{type}</Item.Meta>
          <Item.Description>
            <p>Length: {length}</p>
            <p>Width: {width}</p>
            <p>Height: {height}</p>
            <p>Weight: {weight}</p>
          </Item.Description>
          <Item.Extra>
            {mutation.isPending && <p>Saving...</p>}
            {mutation.isError && <Errors errors={errors} />}
            {mutation.isSuccess && <p>Results saved</p>}
            {mutation.isIdle && (
              <Button primary floated='right' onClick={() => mutation.mutate()}>
                <Icon name='save' />
                Save Results
              </Button>          
            )}
          </Item.Extra>
        </Item.Content>
      </Item>
    </ItemGroup>
  )
};

export default SelectedProduct;