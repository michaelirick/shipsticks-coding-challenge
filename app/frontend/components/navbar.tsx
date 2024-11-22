import { Menu, Container, Button, Icon } from 'semantic-ui-react';
import React from 'react';

interface NavbarProps {
  calculatorOpen: boolean;
  setCalculatorOpen: (open: boolean) => void;
}

const Navbar: React.FC<NavbarProps> = ({ calculatorOpen, setCalculatorOpen }) => {
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