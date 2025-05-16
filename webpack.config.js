const path = require('path');

module.exports = {
    mode: 'production',
    devtool: 'source-map',
    entry: './src/javascript/_bootstrap.js',
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            },
            {
                test: /\.html$/,
                exclude: /node_modules/,
                use: {
                    loader: 'html-loader'
                }
            }
        ]
    }
};