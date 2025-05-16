import { bookProvider } from "./providers/book-provider";

export default function () {
    console.log('Bootstrap index');
    bookProvider.getAllBooks().then((books) => {
        books.forEach((book) => {
            console.log(`Book ID: ${book.id}`);
            console.log(`Title: ${book.title}`);
            console.log(`Start Date: ${book.dateDebut}`);
            console.log(`End Date: ${book.dateFin}`);
        });
    }).catch((error) => {
        console.error('Error fetching books:', error);
    });
};