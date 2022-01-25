<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Nivel extends Model
{
    protected $table = 'niveles';
    use HasFactory;
    public function scopeNivelActivo($query)
    {
        return $query->where('estado', '=', true);
    }
}
