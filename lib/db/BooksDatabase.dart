import 'package:sqflite/sqflite.dart';
import 'package:etsppb/model/book.dart';
import 'package:path/path.dart';

class BooksDatabase{

  // global field
  static final BooksDatabase instance = BooksDatabase._init();

  static Database? _database;

  // private constructor
  BooksDatabase._init();

  // connect to a db
  Future<Database> get database async {
    if (_database != null){
      return _database!;
    }

    _database = await _initDB('books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath); // need path.dart from path ( default package)

    return await openDatabase(path, version: 1, onCreate: _createDB);

  }

  Future _createDB(Database db, int version) async{
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    // if want to do multiple execute, copy ini
    await db.execute(
        '''
    CREATE TABLE $tableBooks (
      ${BookFields.id} $idType,
      ${BookFields.title} $textType,
      ${BookFields.time} $textType,
      ${BookFields.coverUrl} $textType,
      ${BookFields.description} $textType
    )
        '''
    );

  }

  // CREATE from crud
  Future<Book> create(Book book) async {
    final db = await instance.database;
    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time},';

    final id = await db.insert(tableBooks, book.toJson());
    return book.copy(id:id);
  }

  Future<Book> readBook(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBooks,
      columns: BookFields.values,
      where: '${BookFields.id} = ?',
      whereArgs: [id], // prevent sql injection
    );

    if(maps.isNotEmpty){
      return Book.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
      // bisa ini atau return null, and di tipe fungsinya isi ? after note, to indicate, ok could be note, could be null
    }
  }

  Future<List<Book>> readAllBook() async{
    final db = await instance.database;

    // do the query
    const orderBy = '${BookFields.time} ASC';

    final result = await db.query(
        tableBooks,
        orderBy: orderBy
    );

    return result.map((json) => Book.fromJson(json)).toList();
  }

  Future<int> update(Book book) async {
    final db = await instance.database;

    return db.update(
        tableBooks,
        book.toJson(),
        where: '${BookFields.id} = ?',
        whereArgs: [book.id]
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;
    return await db.delete(
        tableBooks,
        where: '${BookFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async{
    final db = await instance.database;

    db.close();
  }

}