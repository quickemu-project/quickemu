import jQuery from 'jquery';

import { AppTitle } from '../components/app-title/app-title';

import 'bootstrap/dist/css/bootstrap.css';
import '../css/ékrityr-snow.css';

(($) => {
    $(() => {
        var bootstrap = $('body').data('bootstrap');
        if (bootstrap) {
            var bootstrapModule = require(`./${bootstrap}`);
            if (bootstrapModule && bootstrapModule.default) {
                const bootstrapFn = bootstrapModule.default;
                bootstrapFn();
            }
        }
    });
})(jQuery);
