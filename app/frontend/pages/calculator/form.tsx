import React from 'react';
import {
  Button,
  Form,
  FormInput
} from 'semantic-ui-react';

const CalculatorForm = ({onSubmit}) => {
  const [length, setLength] = React.useState('');
  const [width, setWidth] = React.useState('');
  const [height, setHeight] = React.useState('');
  const [weight, setWeight] = React.useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit.mutate({
      length: parseInt(length),
      width: parseInt(width),
      height: parseInt(height),
      weight: parseInt(weight)
    });
  }

  return (
    <Form onSubmit={handleSubmit}>
      <FormInput
        label="Length"
        type="number"
        value={length}
        onChange={(e) => setLength(e.target.value)}
      />
      <FormInput
        label="Width"
        type="number"
        value={width}
        onChange={(e) => setWidth(e.target.value)}
      />
      <FormInput
        label="Height"
        type="number"
        value={height}
        onChange={(e) => setHeight(e.target.value)}
      />
      <FormInput
        label="Weight"
        type="number"
        value={weight}
        onChange={(e) => setWeight(e.target.value)}
      />

      <Button type="submit">Calculate</Button>
    </Form>
  );
};

export default CalculatorForm;