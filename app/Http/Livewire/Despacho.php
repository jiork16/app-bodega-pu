<?php

namespace App\Http\Livewire;

use App\Models\TipoMovimiento;
use Livewire\Component;
use Illuminate\Support\Facades\DB;

class Despacho extends Component
{
    protected $listeners = ['refreshData' => 'incrementPostCount'];
    public $data = [];
    public function render()
    {
        $this->data['stock'] = DB::select('call Sp_ReporInventario()');
        $this->data['movimientos'] = TipoMovimiento::movimientoTipo('-')->get();
        return view('livewire.despacho');
    }
}
