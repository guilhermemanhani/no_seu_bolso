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
          CREATE TABLE conta (
            id Integer primary key autoincrement,
            conta VARCHAR(45) not null,
            saldo REAL NOT NULL,
            idbanco Interger NOT NULL,          
            FOREIGN KEY (idbanco) REFERENCES banco (id) ON DELETE NO ACTION ON UPDATE NO ACTION    
          )
        ''');
    batch.execute('''
          CREATE TABLE local (
            id Integer primary key autoincrement,
            descricao VARCHAR(45) not null    
          )
        ''');
    batch.execute('''
          CREATE TABLE motivo (
            id Integer primary key autoincrement,
            descricao VARCHAR(45)   
          )
        ''');
    batch.execute('''
          CREATE TABLE lancamento (
            idlancamento Integer primary key autoincrement,
            valor REAL NOT NULL,
            descricao VARCHAR(45) NULL,
            idbanco Interger NOT NULL,
            localid  Interger NOT NULL,
            motivoid Interger,
            FOREIGN KEY (idbanco) REFERENCES conta (id) ON DELETE NO ACTION ON UPDATE NO ACTION
            FOREIGN KEY (localid) REFERENCES local (id) ON DELETE NO ACTION ON UPDATE NO ACTION
            FOREIGN KEY (motivoid) REFERENCES motivo (id) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
        ''');
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'itau',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'nubank',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'uniprime',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'alelo alimentacao',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'alelo refeicao',
      },
    );
    batch.insert(
      'banco',
      {
        'id': null,
        'instituicao': 'santander',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'descricao': 'posto',
      },
    );
    batch.insert(
      'local',
      {
        'id': null,
        'descricao': 'mercado',
      },
    );
    batch.insert(
      'motivo',
      {
        'id': null,
        'descricao': 'ferias',
      },
    );
    batch.insert(
      'motivo',
      {
        'id': null,
        'descricao': 'posto',
      },
    );
    batch.insert(
      'motivo',
      {
        'id': null,
        'descricao': 'salario',
      },
    );
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