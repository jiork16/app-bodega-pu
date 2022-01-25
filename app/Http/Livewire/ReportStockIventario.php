<?php

namespace App\Http\Livewire;

use Livewire\Component;
use Illuminate\Support\Facades\DB;

class ReportStockIventario extends Component
{
    public function render()
    {
        $dataStock = DB::select('call Sp_ReporInventario()');
        return view('livewire.report-stock-iventario', compact('dataStock'));
    }
}
