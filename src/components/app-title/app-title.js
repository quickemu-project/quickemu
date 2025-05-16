import templateContent from './app-title.html';

class AppTitle extends HTMLElement {
    connectedCallback() {
        this.innerHTML = templateContent;
    }
}

customElements.define('app-title', AppTitle);

export { AppTitle };
