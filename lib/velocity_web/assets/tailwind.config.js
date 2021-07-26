module.exports = {
  purge: ['./src/**/*.jsx'],
  theme: {
    extend: {
      width: {
        '24+2': 'calc(6rem + 2px)',
        '1/24': '4.16667%',
        '2/24': '8.33333%',
        '3/24': '12.5%',
        '4/24': '16.66667%',
        '6/24': '25%',
      },
      height: {
        '24+2': 'calc(6rem + 2px)',
      },
    },
  },
  variants: {},
  plugins: [
    require('./src/tailwind-plugins/triangles/triangles.plugin.js')({
      componentPrefix: 'jst-',
      defaultSize: '6rem',
    }),
  ],
};
