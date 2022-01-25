<?php

namespace Database\Factories;

use App\Models\Localidad;
use Illuminate\Database\Eloquent\Factories\Factory;

class LocalidadFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    protected $localidad = Localidad::class;
    public function definition()
    {
        $localidad = rand(1, 10);
        return [
            'descripcion' =>  'Localidad-' . $localidad
        ];
    }
}
