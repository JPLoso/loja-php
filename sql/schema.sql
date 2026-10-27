#db/schema.sql
CREATE TABLE categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL
);

CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL,
  estoque INT NOT NULL DEFAULT 0,
  categoria_id INT,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);


docker compose exec -T db \
  mysql -uroot -proot loja < db/schema.consql

docker compose exec db \
  mysql -uroot -proot loja -e "SHOW TABLES;"


<?php
namespace App\Database;
use PDO;

class Conexao {
  private static ?PDO $pdo = null;

  public static function get(): PDO {
    if (self::$pdo === null) {
      self::$pdo = new PDO(
        'mysql:host=db;dbname=loja;charset=utf8mb4', 'root', 'root',
        [
          PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
          PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]
      );
    }
    return self::$pdo;
  }
}

$pdo = Conexao::get();

$sql = 'INSERT INTO produtos (nome, preco, estoque) VALUES (:nome, :preco, :estoque)';
$stmt = $pdo->prepare($sql);
$stmt->execute([
  ':nome'    => 'Camiseta',
  ':preco'   => 59.90,
  ':estoque' => 10,
]);
echo 'Inserido com id ' . $pdo->lastInsertId();

