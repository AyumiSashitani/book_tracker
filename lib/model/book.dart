import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  // final String id;
  // final String title;
  final String author;
  final String notes;
  // final String photoUrl;
  final String categories;
  // final String publishedDate;
  // final double? rating;
  final String description;
  // final int pageCount;
  // final Timestamp startedReading;
  // final Timestamp finishedReading;
  // final String userId;

  Book({
    // required this.id,
    // required this.title,
    required this.author,
    required this.notes,
    // required this.photoUrl,
    required this.categories,
    // required this.publishedDate,
    // required this.rating,
    required this.description,
    // required this.pageCount,
    // required this.startedReading,
    // required this.finishedReading,
    // required this.userId,
  });

  factory Book.fromDocument(QueryDocumentSnapshot data) {
    //Map<String, dynamic> info = data.data();
    /*
      Newer firestore sdk versions allow for
      using data.get('pass_field_name')
    */
    return Book(
      // id: data.id,
      // title: data.get('title'),
      author: data.get('author'),
      notes: data.get('notes'),
      // photoUrl: data.get('photo_url'),
      categories: data.get('categories'),
      // publishedDate: data.get('published_date'),
      // rating: parseDouble(data.get('rating')),
      description: data.get('description'),
      // pageCount: data.get('page_count'),
      // startedReading: data.get('started_reading_at'),
      // finishedReading: data.get('finished_reading_at'),
      // userId: data.get('user_id')

      //  title: info['title'],
      // author: info['author'],
      // notes: info['notes'],
      // photoUrl: info['photo_url'],
      // categories: info['categories'],
      // publishedDate: info['published_date'],
      // rating: parseDouble(info['rating']),

      // description: info['description'],
      // pageCount: info['page_count'],
      // startedReading: info['started_reading_at'],
      // finishedReading: info['finished_reading_at'],
      // userId: info['user_id']
    );
  }
  Map<String, dynamic> toMap() {
    return {
      // 'title': title,
      // 'user_id': userId,
      'author': author,
      'notes': notes,
      // 'photo_url': photoUrl,
      // 'published_date': publishedDate,
      // 'rating': rating,
      'description': description,
      // 'page_count': pageCount,
      // 'started_reading_at': startedReading,
      // 'finished_reading_at': finishedReading,
      'categories': categories,
    };
  }
}
