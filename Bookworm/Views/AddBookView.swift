//
//  AddBookView.swift
//  Bookworm
//
//  Created by Baptiste Cadoux on 15/11/2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var showingMissingGenre = false

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
                        if genre.isEmpty {
                            showingMissingGenre = true
                            return
                        }

                        let newBook = Book(context: moc)
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.addingDate = Date.now

                        try? moc.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert(isPresented: $showingMissingGenre) {
                Alert(title: Text("/!\\"),
                      message: Text("You must choose a genre."),
                      dismissButton: .cancel())
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
