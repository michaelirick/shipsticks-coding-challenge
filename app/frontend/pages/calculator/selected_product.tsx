import React from "react";
import { Item, ItemGroup } from "semantic-ui-react"

const SelectedProduct = ({name, type, length, width, height, weight, dimensions}) => {
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
        </Item.Content>
      </Item>
    </ItemGroup>
  )
};

export default SelectedProduct;