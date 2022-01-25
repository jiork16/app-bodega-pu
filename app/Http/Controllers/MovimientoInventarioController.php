<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\MovimientoInventarioRequest;
use App\Models\MovimientoInventario;

class MovimientoInventarioController extends Controller
{
    public function __construct()
    {
        //$this->middleware('has.token');
    }
    public function store(MovimientoInventarioRequest $request)
    {
        $store = $request->validated();
        if (!isset($request->id_movimiento)) {
            $store['id_usuario_ing'] = auth()->user()->id;
            MovimientoInventario::create($store);
            return back()->with('messageSaveMove', 'Ingresado Con Exito');
        } else {
            $store =  MovimientoInventario::find($store['id_movimiento']);
            MovimientoInventario::create([
                'id_producto' =>  $store->id_producto,
                'id_medida' =>  $store->id_medida,
                'id_localidad' =>  $store->id_localidad,
                'id_tipo_movimiento' =>  $request->id_tipo_movimiento,
                'nivel' =>  $store->nivel,
                'cantidad' =>  $request->cantidad,
                'fecha_movimiento' =>  now(),
                'id_bodega' =>  $store->id_bodega,
                'id_usuario_ing' =>  auth()->user()->id,
                'lote' => $store->lote
            ]);
            return $this->success(
                [$request],
                'Movimiento Ingresado con Exito'
            );
        }
    }
}
