import { Dexie } from 'dexie';

class AbstractProvider {
    constructor() {
        this.db = new Dexie('ékrityr');
        this.db.version(1).stores({
            books: `++id`,
        });
    }
}

export { AbstractProvider };
