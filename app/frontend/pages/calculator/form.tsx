import React from 'react';
import {
  Button,
  Form,
  FormInput
} from 'semantic-ui-react';

interface CalculatorFormProps {
  onSubmit: {
    mutate: (data: { length: number; width: number; height: number; weight: number }) => void;
  };
}

const CalculatorForm: React.FC<CalculatorFormProps> = ({ onSubmit }) => {
  const [length, setLength] = React.useState<string>('');
  const [width, setWidth] = React.useState<string>('');
  const [height, setHeight] = React.useState<string>('');
  const [weight, setWeight] = React.useState<string>('');

  const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    onSubmit({
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
        onChange={(e: React.ChangeEvent<HTMLInputElement>) => setLength(e.target.value)}
      />
      <FormInput
        label="Width"
        type="number"
        value={width}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) => setWidth(e.target.value)}
      />
      <FormInput
        label="Height"
        type="number"
        value={height}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) => setHeight(e.target.value)}
      />
      <FormInput
        label="Weight"
        type="number"
        value={weight}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) => setWeight(e.target.value)}
      />

      <Button type="submit" disabled={length.length === 0 || width.length === 0 || height.length === 0 || weight.length === 0}>
        Calculate
      </Button>
    </Form>
  );
};

export default CalculatorForm;