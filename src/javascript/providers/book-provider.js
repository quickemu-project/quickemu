import { AbstractProvider } from "./abstract-provider";
import { Book } from "/src/javascript/model/book";

class BookProvider extends AbstractProvider {
    constructor() {
        super();
    }

    /**
     * @returns {Promise<Book[]>}
     */
    async getAllBooks() {
        return this.db.books.toArray();
    }
}

const bookProvider = new BookProvider();

export { bookProvider };
