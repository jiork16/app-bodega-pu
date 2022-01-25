<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MovimientoInventario extends Model
{
    use HasFactory;
    protected $fillable = [
        'id_producto',
        'id_medida',
        'id_localidad',
        'id_tipo_movimiento',
        'nivel',
        'cantidad',
        'fecha_movimiento',
        'id_bodega',
        'id_usuario_ing',
        'lote'
    ];
    public function scopeMovimientos($query)
    {
        return $query->join('productos', 'movimiento_inventarios.id_producto', '=', 'productos.id')
            ->join('medidas', 'movimiento_inventarios.id_medida', '=', 'medidas.id')
            ->join('bodegas', 'movimiento_inventarios.id_bodega', '=', 'bodegas.id')
            ->join('localidades', 'movimiento_inventarios.id_localidad', '=', 'localidades.id')
            ->join('tipo_movimientos', 'movimiento_inventarios.id_tipo_movimiento', '=', 'tipo_movimientos.id')
            ->join('niveles', 'movimiento_inventarios.nivel', '=', 'niveles.id')
            ->select(array(
                'movimiento_inventarios.created_at', 'movimiento_inventarios.id', 'cantidad', 'fecha_movimiento', 'id_producto', 'id_medida', 'id_bodega', 'id_localidad', 'id_tipo_movimiento', 'nivel', 'id_usuario_ing', 'movimiento_inventarios.created_at', 'movimiento_inventarios.updated_at', 'medidas.descripcion as medida', 'bodegas.descripcion as bodega', 'localidades.descripcion  as localidad', 'tipo_movimientos.descripcion  as movimiento', 'niveles.descripcion as dnivel', 'productos.cod_producto', 'productos.descripcion as producto'
            ));
    }
}
