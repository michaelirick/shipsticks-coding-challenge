import { defineConfig } from 'windicss/helpers'

export default defineConfig({
  theme: {
    backgroundImage: {
      "hero": "url('/Background.png')",
      "hero-mobile": "url('/MobileBackground.jpeg')",
    },
    boxShadow: {
      "button-inset": "0 3px 0 0 #4fab55",
      "card": "1px 2px 5px 0 rgb(37 37 37 / 14%);"
    }
  }
})
