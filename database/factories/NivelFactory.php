<?php

namespace Database\Factories;

use App\Models\Nivel;
use Illuminate\Database\Eloquent\Factories\Factory;

class NivelFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    protected $model = Nivel::class;
    public function definition()
    {
        $nivel = random_int(1, 4);
        return [
            'descripcion' => 'Nivel-' . $nivel
        ];
    }
}
