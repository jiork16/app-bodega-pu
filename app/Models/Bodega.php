<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bodega extends Model
{
    use HasFactory;
    public function scopeBodegaActiva($query)
    {
        return $query->where('estado', '=', true);
    }
}
