<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;
    public function scopeProductoActivo($query)
    {
        return $query->where('estado', '=', true);
    }
    public function scopeProductoCategoria($query, $idBodega)
    {
        return $query->where([['id_categoria', '=', $idBodega], ['estado', '=', true]]);
    }
}
