import React, { useState } from 'react';
import { Menu, Container, Button, Icon } from 'semantic-ui-react';
import { Link } from 'react-router-dom';

const Navbar = () => {
  const [activeItem, setActiveItem] = useState('home');

  const handleItemClick = (e, { name }) => setActiveItem(name);

  return (
    <Menu inverted>
      <Container>
        <Menu.Item
          as={Link}
          to="/"
          name="home"
          active={activeItem === 'home'}
          onClick={handleItemClick}
        >
          <Icon name="home" />
          Home
        </Menu.Item>
        <Menu.Item
          as={Link}
          to="/products"
          name="products"
          active={activeItem === 'products'}
          onClick={handleItemClick}
        >
          <Icon name="shop" />
          Products
        </Menu.Item>
      </Container>
    </Menu>
  );
};

export default Navbar;