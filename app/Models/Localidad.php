<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Localidad extends Model
{
    protected $table = 'localidades';
    use HasFactory;
    public function scopeLocalidadActiva($query)
    {
        return $query->where('estado', '=', true);
    }
}
