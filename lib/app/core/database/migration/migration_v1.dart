import 'package:dentro_do_bolso/app/core/database/migration/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''

  CREATE TABLE banco (
    idbanco INT NOT NULL,
    bancocol VARCHAR(45) NULL,
    PRIMARY KEY (idbanco)
    )

  CREATE TABLE lancamento (
    idlancamento INT NOT NULL AUTO_INCREMENT,
    valor DECIMAL(100) NULL,
    lancamentocol VARCHAR(45) NULL,
    banco_idbanco INT NOT NULL,
    PRIMARY KEY (idlancamento),
    INDEX fk_lancamento_banco_idx (banco_idbanco ASC) VISIBLE,
    CONSTRAINT fk_lancamento_banco
      FOREIGN KEY (banco_idbanco)
      REFERENCES banco (idbanco)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
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
//           "id integer primary key, userId integer, typeId integer,"
//           "gradeId integer, price DOUBLE" 
//           "FOREIGN KEY (typeId) REFERENCES Type (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
//           "FOREIGN KEY (userId) REFERENCES User (id) ON DELETE NO ACTION ON UPDATE NO ACTION," 
//           "FOREIGN KEY (gradeId) REFERENCES Grade (id) ON DELETE NO ACTION ON UPDATE NO ACTION"
//           ")