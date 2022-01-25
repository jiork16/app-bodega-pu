<?php

namespace App\Traits;

/*
|--------------------------------------------------------------------------
| Api Responser Trait
|--------------------------------------------------------------------------
|
| This trait will be used for any response we sent to clients.
|
*/

trait Responser
{
    /**
     * Return a success JSON response.
     *
     * @param  array|string  $data
     * @param  string  $message
     * @param  int|null  $code
     * @return \Illuminate\Http\JsonResponse
     */
    protected function success($data, string $message = null, int $code = 200)
    {
        return response()->json(array_merge([
            'status' => '¡Solicitud Éxitosa!',
            'message' => $message,
        ], $data), $code);
    }

    /**
     * Return an error JSON response.
     *
     * @param  string  $message
     * @param  int  $code
     * @param  array|string|null  $data
     * @return \Illuminate\Http\JsonResponse
     */
    protected function error(string $message = null, int $code, $data = null)
    {
        return response()->json([
            'status' => 'Error',
            'message' => $message,
            'data' => $data
        ], $code);
    }
    /**
     * Indica la cantidad de registros encontrados de
     * un modelo en particular.
     *
     * @param  string  $modelSing - el nombre del modelo en singular
     * @param  string  $modelPlur - el nombre del modelo en plural
     *
     * @param  int  $count - conteo del modelo
     * @return string $message - el mensaje acorde al conteo
     */
    protected function foundNMessage(int $count = 0,    string $modelSing = "recurso",    string $modelPlur = "recursos")
    {
        if ($count < 1) {
            return "No se han encontrado " . $modelPlur . " bajo los parámetros actuales.";
        } else if ($count == 1) {
            return "Se encontró 1 " . $modelSing;
        } else {
            return "Se han encontrado " . $count . " " . $modelPlur . ".";
        }
    }
}
