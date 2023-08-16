import { Button } from ".";

export default {
  title: "Components/Button",
  component: Button,
  argTypes: {
    type: {
      options: ["full", "stroke", "none", "full-disabled"],
      control: { type: "select" },
    },
  },
};

export const Default = {
  args: {
    type: "full",
    className: {},
    divClassName: {},
    text: "Button text",
  },
};
