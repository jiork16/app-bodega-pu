<?php

use App\Http\Controllers\MovimientoInventarioController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PageController;
use App\Http\Controllers\ProductoController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('auth.login');
});

Route::middleware(['auth:sanctum', 'verified'])->group(function () {
    Route::post('moviento_inventario', [MovimientoInventarioController::class, 'store'])->name('moviento_inventario');
    Route::get('productos/{id}', [ProductoController::class, 'indexCategoria'])->name('productos');
    Route::get('/dashboard', [PageController::class, 'index']);
    Route::get('/movimiento', function () {
        return view('movimiento.movimiento-inventario');
    })->name('movimiento');
    Route::get('/despacho', function () {
        return view('despacho.despacho');
    })->name('despacho');
});
