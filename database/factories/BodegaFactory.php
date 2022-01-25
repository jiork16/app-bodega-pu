<?php

namespace Database\Factories;

use App\Models\Bodega;
use Illuminate\Database\Eloquent\Factories\Factory;

class BodegaFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    protected $model = Bodega::class;
    public function definition()
    {
        $bodega = rand(1, 4);
        return [
            'descripcion' =>  'Bodega' . $bodega
        ];
    }
}
