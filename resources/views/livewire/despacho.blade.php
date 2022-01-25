<script src="{{ asset('js/despacho/despacho.js') }}"></script>
@if (session()->has('messageSaveMove'))
    <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>Registro!</strong> {{ session()->get('messageSaveMove') }}
    </div>
@endif
<section class="py-2 mx-auto bg-white rounded-md shadow-md dark:bg-gray-800 px-4">
    <table id="tblDespacho" class="stripe display compact table table-striped table-bordered">
        <thead>
            <tr>
                <th>#</th>
                <th></th>
                <th>LOTE</th>
                <th>CATEGORIA</th>
                <th>COD_PRODUCTO</th>
                <th>PRODUCTO</th>
                <th>Medida</th>
                <th>Bodega</th>
                <th>Localidad</th>
                <th>Nivel</th>
                <th>Total</th>
            </tr>
        <tbody>
            @foreach ($data['stock'] as $stock)
                <tr>
                    <td>{{ $stock->id }}</td>
                    <td>
                        <button type="button" data-toggle="modal" data-target="#modalValor"
                            class="btn btn-success btn-rounded btn-sm m-0" id="btnDespachar">Despachar</button>
                    </td>
                    <td>{{ $stock->lote }}</td>
                    <td>{{ $stock->Categoria }}</td>
                    <td>{{ $stock->cod_producto }}</td>
                    <td>{{ $stock->Producto }}</td>
                    <td>{{ $stock->Medida }}</td>
                    <td>{{ $stock->Bodega }}</td>
                    <td>{{ $stock->Localidad }}</td>
                    <td>{{ $stock->Nivel }}</td>
                    <td>{{ $stock->Total }}</td>
                </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr>
                <td></td>
                <td></td>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <td></td>
            </tr>
        </tfoot>
        </thead>
    </table>
</section>
<!-- Modal -->
<div class="modal fade" id="modalValor" tabindex="-1" aria-labelledby="modalValorLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        @if ($errors->any())
            @foreach ($errors->all() as $error)
                <div class="alert alert-danger alert-dismissable">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Error!</strong> {{ $error }}
                </div>
            @endforeach
        @endif
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalValorLabel">Detalle a Despachar</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="POST" action="{{ route('moviento_inventario') }}" id="formMovimiento">
                <div class="modal-body">
                    @csrf
                    <div class="grid grid-cols-1 gap-3 mt-1 sm:grid-cols-3">
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Lote:</label>
                            <div class="col-sm-9">
                                <input type="text" id="lote" name="lote" readonly class="form-control-plaintext"
                                    placeholder="Disabled input">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Categoria:</label>
                            <div class="col-sm-9 pl-4">
                                <input type="text" id="categoria" name="categoria" readonly
                                    class="form-control-plaintext" placeholder="Disabled input" style="font-size: 85%">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-7 pr-0"
                                for="passwordConfirmation">Codigo-Producto:</label>
                            <div class="col-sm-5 pl-0">
                                <input type="text" id="id_producto" name="id_producto" readonly
                                    class="form-control-plaintext" placeholder="Disabled input">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Producto:</label>
                            <div class="col-sm-9 pl-4">
                                <input type="text" id="producto" name="producto" readonly class="form-control-plaintext"
                                    style="font-size: 90%">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Medida:</label>
                            <div class="col-sm-9">
                                <input type="text" id="id_medida" name="id_medida" readonly
                                    class="form-control-plaintext" placeholder="Disabled input">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Bodega:</label>
                            <div class="col-sm-9">
                                <input type="text" id="id_bodega" name="id_bodega" readonly
                                    class="form-control-plaintext" placeholder="Disabled input">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Localidad:</label>
                            <div class="col-sm-9 pl-4">
                                <input type="text" id="id_localidad" name="id_localidad" readonly
                                    class="form-control-plaintext" placeholder="Disabled input">
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-3"
                                for="passwordConfirmation">Nivel:</label>
                            <div class="col-sm-9">
                                <input type="text" id="nivel" name="nivel" readonly class="form-control-plaintext"
                                    placeholder="Disabled input">
                            </div>
                        </div>
                        <div class="form-group row mb-0 display: flex flex-wrap: wrap margin: -0.5rem">
                            <label
                                class="text-black dark:text-gray-200 col-form-label col-sm-4 pr-0 ">Movimiento:</label>
                            <div class="col-sm-8 text-sm">
                                <select id="id_tipo_movimiento" name="id_tipo_movimiento"
                                    class="form-control p-0 text-sm" style="font-size: 90%">
                                    @foreach ($data['movimientos'] as $movimiento)
                                        <option value="{{ $movimiento->id }}" class="text-xs">
                                            {{ $movimiento->descripcion . '(' . $movimiento->accion . ')' }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <label class="text-black dark:text-gray-200 col-form-label col-sm-8 pr-0"
                                id="cant_ant">Cantidad Despachar:</label>
                            <div class="col-sm-4 pl-0">
                                <input type="number" id="cantidad" name="cantidad" class="form-control">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="btnGuardarDespacho"
                        name="id_movimiento">Despachar</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<style>
    div.dataTables_wrapper div.dataTables_length select {
        width: 50%;
    }

</style>
<style>
    input[type='number']::-webkit-inner-spin-button,
    input[type='number']::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    .custom-number-input input:focus {
        outline: none !important;
    }

    .custom-number-input button:focus {
        outline: none !important;
    }

</style>
<script>
    despachoJs = new despacho();
    $(document).ready(function() {
        /*Inicializa funciones para el ingreso de movimiento*/
        despachoJs.funcionesInicial();
    });
</script>
