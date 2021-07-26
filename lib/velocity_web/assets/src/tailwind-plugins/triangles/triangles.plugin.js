const plugin = require('tailwindcss/plugin');
const valueParser = require('postcss-value-parser');

const defaultOptions = {
  componentPrefix: 'c-',
  defaultSize: '1em',
  defaultColor: 'currentColor',
};

const defaultTheme = (theme) => {
  const allColors = Object.entries(theme('colors'))
    .filter(([colorName]) => !['current', 'transparent', 'black', 'white'].includes(colorName))
    .flatMap(([colorName, colorKeys]) =>
      Object.keys(colorKeys).map((colorKey) => ({
        className: `${colorName}-${colorKey}`,
        color: theme(`colors.${colorName}.${colorKey}`),
      })),
    );

  return ['left', 'right']
    .flatMap((direction) =>
      allColors.map(({ className, color }) => ({
        fullClassName: `${direction}-${className}`,
        direction,
        color,
      })),
    )
    .reduce((acc, { fullClassName, direction, color }) => ({
      ...acc,
      [fullClassName]: { direction, color },
    }));
};

module.exports = plugin.withOptions(
  (options = {}) => ({ theme, e, addComponents }) => {
    options = Object.assign({}, defaultOptions, options);

    const trianglesComponents = Object.keys(theme('triangles'))
      .map((optionKey) => {
        const triangle = Object.assign(
          {},
          {
            size: options.defaultSize,
            color: options.defaultColor,
          },
          theme('triangles')[optionKey],
        );
        triangle.name = `triangle-${optionKey}`;
        triangle.parsedSize = valueParser.unit(triangle.size);
        triangle.styles = {
          width: '0',
          height: '0',
          border: '0',
        };

        const solidBorderValue = `${triangle.size} solid ${triangle.color}`;
        const transparentBorderValue = `${triangle.size} solid transparent`;
        switch (triangle.direction) {
          case 'left':
            triangle.styles.borderTop = solidBorderValue;
            triangle.styles.borderRight = transparentBorderValue;
            break;
          case 'right':
            triangle.styles.borderBottom = solidBorderValue;
            triangle.styles.borderLeft = transparentBorderValue;
            break;
          default:
            break;
        }

        return [`.${e(`${options.componentPrefix}${triangle.name}`)}`, triangle.styles];
      })
      .reduce((acc, [className, values]) => ({ ...acc, [className]: values }), {});

    addComponents(trianglesComponents);
  },
  () => ({
    theme: {
      triangles: (theme) => defaultTheme(theme),
    },
    variants: {
      triangles: [],
    },
  }),
);
