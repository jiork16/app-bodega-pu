<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MovimientoInventarioRequest extends FormRequest
{

    private $rulesMovimiento = [
        'id_producto' => 'required|numeric|exists:productos,id',
        'id_medida' => 'required|numeric|exists:medidas,id',
        'id_bodega' => 'required|numeric|exists:bodegas,id',
        'id_localidad' => 'required|numeric|exists:localidades,id',
        'id_tipo_movimiento' => 'required|numeric|exists:tipo_movimientos,id',
        'nivel' => 'required|numeric|exists:niveles,id',
        'cantidad' => 'required|numeric',
        'fecha_movimiento' => 'required|date',
        'lote' => 'required|numeric'
    ];
    private $rulesDespacho = [
        'id_movimiento' => 'required|numeric|exists:movimiento_inventarios,id',
        'cantidad' => 'required|numeric',
        'id_tipo_movimiento' => 'required|numeric|exists:tipo_movimientos,id'
    ];
    private $messageMovimiento = [
        'id_producto.required|numeric|exists:productos,id'    => 'Necesita Espeficicar el producto.',
        'id_medida.required|numeric|exists:medidas,id'        => 'Necesita Espeficicar la medida.',
        'id_bodega.required|numeric|exists:bodegas,id'       => 'Necesita Espeficicar la bodega.',
        'id_localidad.required|numeric|exists:localidades,id'    => 'Necesita Espeficicar la localidad.',
        'id_tipo_movimiento.required|numeric|exists:tipo_movimientos,id'     => 'Necesita Espeficicar el movimiento.',
        'nivel.required|numeric|exists:niveles,id'     => 'Necesita Espeficicar el nivel.',
        'cantidad.required|numeric'     => 'Necesita Espeficicar la cantidad.',
        'fecha_movimiento.required|date'     => 'Necesita Espeficicar la fecha del movimiento',
        'lote.required|numeric'     => 'Necesita Espeficicar el lote.'
    ];
    private $messageDespacho = [
        'id_movimiento.required'    => 'No se a indicado el movimiento.',
        'cantidad.required|numeric'     => 'Necesita Espeficicar la cantidad.'
    ];
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $datos = $this->request->all();
        if (isset($datos["id_movimiento"])) {
            return $this->rulesDespacho;
        } else {
            return $this->rulesMovimiento;
        }
    }
    public function messages()
    {
        $datos = $this->request->all();
        if (isset($datos["id_movimiento"])) {
            return $this->messageDespacho;
        } else {
            return $this->messageMovimiento;
        }
    }
}
