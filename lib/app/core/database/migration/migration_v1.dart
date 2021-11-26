import 'package:dentro_do_bolso/app/core/database/migration/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
          CREATE TABLE banco (
            id Integer primary key autoincrement,
            instituicao VARCHAR(45) not null    
          )
        ''');
    batch.execute('''
          CREATE TABLE lancamento (
            idlancamento Integer primary key autoincrement,
            valor REAL NOT NULL,
            descricao VARCHAR(45) NULL,
            idbanco Interger NOT NULL,
            FOREIGN KEY (idbanco) REFERENCES banco (id) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
        ''');
  }

  @override
  void update(Batch batch) {}
}
//  create table todo(
//       id Integer primary key autoincrement,
//       descricao varchar(500) not null,
//       data_hora datetime,
//       finalizado interger
//     )

// CREATE TABLE MarketInfoes ("
//      "id integer primary key, 
//      userId integer, 
//      typeId integer,"
//      "gradeId integer,
//       price DOUBLE" 
//      "FOREIGN KEY (typeId) REFERENCES Type (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
//      "FOREIGN KEY (userId) REFERENCES User (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
//      "FOREIGN KEY (gradeId) REFERENCES Grade (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
//    ")