import {
  MessageItem, 
  MessageList,
  MessageHeader,
  Message
} from "semantic-ui-react"

interface ErrorsProps {
  errors: Record<string, string>;
}

const Errors: React.FC<ErrorsProps> = ({ errors }) => {
  return (
    <Message negative>
      <MessageHeader>Errors</MessageHeader>
      <MessageList>
        {Object.keys(errors).map((key) => {
          return (
            <MessageItem key={key}>{key}: {errors[key]}</MessageItem>
          )
        })}
      </MessageList>
    </Message>
  )
};

export default Errors;