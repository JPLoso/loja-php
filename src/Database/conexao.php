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