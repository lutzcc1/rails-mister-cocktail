const { environment } = require('@rails/webpacker')

// Bootstrap 4 has a dependency over jQuery & Popper.js:
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',//'jquery',
    jQuery: 'jquery/src/jquery',//'jquery',
    Popper: ['popper.js', 'default']
  })
)

module.exports = environment
