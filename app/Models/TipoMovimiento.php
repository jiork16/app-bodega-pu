<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoMovimiento extends Model
{
    use HasFactory;
    public function scopeTipoMovientoActivo($query)
    {
        return $query->where('estado', '=', true);
    }
    public function scopeMovimientoTipo($query, $accion)
    {
        return $query->where([['accion', '=', $accion], ['estado', '=', true]]);
    }
}
