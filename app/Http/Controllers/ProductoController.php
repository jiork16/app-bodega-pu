<?php

namespace App\Http\Controllers;

use App\Http\Resources\ProductoResource;
use App\Models\Producto;
use Illuminate\Http\Request;

class ProductoController extends Controller
{
    public function indexCategoria(int $id)
    {
        $productos = new ProductoResource(Producto::productoCategoria($id)->get());
        return $productos;
    }
}
