<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Nivel;
use App\Models\Bodega;
use App\Models\Medida;
use App\Models\Producto;
use App\Models\Localidad;
use App\Models\TipoMovimiento;
use Illuminate\Database\Seeder;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::factory(10)->create();
        Bodega::factory(3)->create();
        Localidad::factory(3)->create();
        Nivel::factory(5)->create();

        /*  Producto::create([
            'cod_producto' => 'LS-1000',
            'descripcion' => 'LATEX SUPREMO BLANCO'
        ]);
        Producto::create([
            'cod_producto' => 'SS-1000',
            'descripcion' => 'SUPREMO SATINADO'
        ]);
        Producto::create([
            'cod_producto' => 'SPEA-1000',
            'descripcion' => 'ELASTOMERICO BLANCO'
        ]);
        Producto::create([
            'cod_producto' => '600',
            'descripcion' => 'ANTICORROSIVO NEGRO'
        ]); */
        Medida::create([
            'codigo' => 'A',
            'descripcion' => 'GALON'
        ]);
        Medida::create([
            'codigo' => 'B',
            'descripcion' => 'LITRO'
        ]);
        Medida::create([
            'codigo' => 'C',
            'descripcion' => 'CUARTO DE LITO'
        ]);
        Medida::create([
            'codigo' => 'D',
            'descripcion' => 'OCTAVO DE LITRO'
        ]);
        TipoMovimiento::create([
            'accion' => '+',
            'descripcion' => 'TRASPASO DE BODEGA'
        ]);
        TipoMovimiento::create([
            'accion' => '+',
            'descripcion' => 'PRODUCION'
        ]);
        TipoMovimiento::create([
            'accion' => '-',
            'descripcion' => 'DESAPACHO'
        ]);
        TipoMovimiento::create([
            'accion' => '-',
            'descripcion' => 'TRASPASO A BODEGA'
        ]);
        TipoMovimiento::create([
            'accion' => '-',
            'descripcion' => 'TRASPASO COLORES ESPECIALES'
        ]);
    }
}
