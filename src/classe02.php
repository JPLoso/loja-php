<?php

class Animal {
    const TIPO = "Animal";

    public static function identificar(): string {
        //return self::TIPO;
        return static::TIPO;
    }
}

class Cachorro extends Animal {
    const TIPO = "Cachorro"
}
echo Cachorro::identificar();