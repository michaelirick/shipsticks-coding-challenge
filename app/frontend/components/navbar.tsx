import React, { useState } from 'react';
import { Menu, Container, Button, Icon } from 'semantic-ui-react';
import { Link } from 'react-router-dom';
import CalculatorModal from 'pages/calculator/modal';

const Navbar = ({calculatorOpen, setCalculatorOpen}) => {

  return (
    <Menu inverted>
      <Container>
        <Menu.Item
          as={Button}
          name="Launch Calculator"
          active={calculatorOpen}
          onClick={() => setCalculatorOpen(true)}
        >
          <Icon name="calculator" />
          Launch Calculator
        </Menu.Item>
      </Container>
    </Menu>
  );
};

export default Navbar;