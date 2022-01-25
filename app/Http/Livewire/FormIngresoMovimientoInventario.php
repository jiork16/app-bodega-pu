<?php

namespace App\Http\Livewire;

use App\Models\Nivel;
use App\Models\Bodega;
use App\Models\Medida;
use Livewire\Component;
use App\Models\Producto;
use App\Models\Categoria;
use App\Models\Localidad;
use App\Models\TipoMovimiento;
use App\Models\MovimientoInventario;

class FormIngresoMovimientoInventario extends Component
{
    public function render()
    {
        $data['movimientos'] = TipoMovimiento::tipoMovientoActivo()->get();
        $data['productos'] = Producto::productoActivo()->get();
        $data['medidas'] = Medida::medidaActiva()->get();
        $data['bodegas'] = Bodega::bodegaActiva()->get();
        $data['localidades'] = Localidad::localidadActiva()->get();
        $data['niveles'] = Nivel::nivelActivo()->get();
        $data['categorias'] = Categoria::categoriaActiva()->get();
        $data['reporte'] = MovimientoInventario::movimientos()->orderBy('created_at', 'desc')->get();
        //dd($data['reporte']);
        return view('livewire.form-ingreso-movimiento-inventario', compact('data'));
    }
}
