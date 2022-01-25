<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medida  extends Model
{
    use HasFactory;
    public function scopeMedidaActiva($query)
    {
        return $query->where('estado', '=', true);
    }
}
