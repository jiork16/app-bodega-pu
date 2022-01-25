<script src="{{ asset('js/ingreso_movimiento/ingreso.js') }}"></script>
<meta name="csrf-token" content="{{ csrf_token() }}">
@if ($errors->any())
    @foreach ($errors->all() as $error)
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>¡Error!</strong> {{ $error }}
        </div>
    @endforeach
@endif
@if (session()->has('messageSaveMove'))
    <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>Registro!</strong> {{ session()->get('messageSaveMove') }}
    </div>
@endif
<section class="p-4 pt-1 mx-auto bg-indigo-600 rounded-md shadow-md dark:bg-gray-800  my-0">
    <form method="POST" action="{{ route('moviento_inventario') }}" id="formMovimiento">
        @csrf
        <div class="grid grid-cols-1 gap-3 mt-4 sm:grid-cols-4">
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Fecha Movimiento</label>
                <input id="fecha_movimiento" name="fecha_movimiento" onload="getDate()" type="date"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Movimiento</label>
                <select id="id_tipo_movimiento" name="id_tipo_movimiento"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    @foreach ($data['movimientos'] as $movimiento)
                        <option value="{{ $movimiento->id }}">
                            {{ $movimiento->descripcion . '(' . $movimiento->accion . ')' }} </option>
                    @endforeach
                </select>
            </div>
            <div>
                <label for="cantidad" class="text-white dark:text-gray-200">Cantidad
                </label>
                <div class="flex flex-row h-10 w-full rounded-lg relative bg-transparent mt-2">
                    <button data-action="decrement"
                        class=" bg-gray-300 text-gray-600 hover:text-gray-700 hover:bg-gray-400 h-full w-20 rounded-l cursor-pointer outline-none">
                        <span class="m-auto text-2xl font-thin">−</span>
                    </button>
                    <input type="number" id="cantidad"
                        class="focus:outline-none text-center w-full bg-white font-semibold text-md hover:text-black focus:text-black  md:text-basecursor-default flex items-center text-gray-700  outline-none"
                        name="cantidad" value="0"></input>
                    <button data-action="increment"
                        class="bg-gray-300 text-gray-600 hover:text-gray-700 hover:bg-gray-400 h-full w-20 rounded-r cursor-pointer">
                        <span class="m-auto text-2xl font-thin">+</span>
                    </button>
                </div>
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Lote</label>
                <input id="lote" name="lote"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring"
                    type="text" aria-label="Full name">
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Categoria</label>
                <select id="id_categoria" name="id_categoria"
                    class="selectpicker  w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    @foreach ($data['categorias'] as $categoria)
                        <option value="{{ $categoria->id }}">
                            {{ $categoria->descripcion }} </option>
                    @endforeach
                </select>
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Producto</label>
                <select id="id_producto" name="id_producto"
                    class="selectpicker  w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    {{-- @foreach ($data['productos'] as $producto)
                        <option value="{{ $producto->id }}">
                            {{ $producto->cod_producto . '-' . $producto->descripcion }} </option>
                    @endforeach --}}
                </select>
            </div>

            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Medida</label>
                <select id="id_medida" name="id_medida"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    @foreach ($data['medidas'] as $medida)
                        <option value="{{ $medida->id }}">
                            {{ $medida->codigo . '-' . $medida->descripcion }} </option>
                    @endforeach
                </select>
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Bodega</label>
                <select id="id_bodega" name="id_bodega"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    @foreach ($data['bodegas'] as $bodega)
                        <option value="{{ $bodega->id }}">
                            {{ $bodega->descripcion }} </option>
                    @endforeach
                </select>
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Localidad</label>
                <select id="id_localidad" name="id_localidad"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    @foreach ($data['localidades'] as $localidade)
                        <option value="{{ $localidade->id }}">
                            {{ $localidade->descripcion }} </option>
                    @endforeach
                </select>
            </div>
            <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Nivel</label>
                <select id="nivel" name="nivel"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring">
                    @foreach ($data['niveles'] as $nivel)
                        <option value="{{ $nivel->id }}">
                            {{ $nivel->descripcion }} </option>
                    @endforeach
                </select>
            </div>
            {{-- <div>
                <label class="text-white dark:text-gray-200" for="passwordConfirmation">Text Area</label>
                <textarea id="textarea" type="textarea"
                    class="block w-full px-4 py-2 mt-2 text-gray-700 bg-white border border-gray-300 rounded-md dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 focus:border-blue-500 dark:focus:border-blue-500 focus:outline-none focus:ring"></textarea>
            </div>
            <div>
                <label class="block text-sm font-medium text-white">
                    Image
                </label>
                <div class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-gray-300 border-dashed rounded-md">
                    <div class="space-y-1 text-center">
                        <svg class="mx-auto h-12 w-12 text-white" stroke="currentColor" fill="none" viewBox="0 0 48 48"
                            aria-hidden="true">
                            <path
                                d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                        <div class="flex text-sm text-gray-600">
                            <label for="file-upload"
                                class="relative cursor-pointer bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus-within:outline-none focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-indigo-500">
                                <span class="">Upload a file</span>
                                <input id="file-upload" name="file-upload" type="file" class="sr-only">
                            </label>
                            <p class="pl-1 text-white">or drag and drop</p>
                        </div>
                        <p class="text-xs text-white">
                            PNG, JPG, GIF up to 10MB
                        </p>
                    </div>
                </div>
            </div> --}}
        </div>

        <div class="flex justify-end  pt-0 mt-auto">
            <button
                class="px-6 py-2 leading-5 text-white transition-colors duration-200 bg-pink-500 rounded-md hover:bg-pink-700 focus:outline-none focus:bg-gray-600">Save</button>
        </div>
    </form>
</section>
<section class="p-6 mx-auto bg-white rounded-md shadow-md dark:bg-gray-800 mt-1">
    <h2 class="text-lg font-semibold text-gray-700 capitalize dark:text-white">Account settings</h2>
    <table id="tblMovimiento" class="stripe display compact table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>#</th>
                <th>Fecha Movimiento</th>
                <th>Movimiento</th>
                <th>Cantidad</th>
                <th>Producto</th>
                <th>Medida</th>
                <th>Bodega</th>
                <th>Localidad</th>
                <th>Nivel</th>
            </tr>
        <tbody>

            @foreach ($data['reporte'] as $report)
                <tr>
                    <td>{{ $report->id }}</td>
                    <td>{{ $report->fecha_movimiento }}</td>
                    <td>{{ $report->movimiento }}</td>
                    <td>{{ $report->cantidad }}</td>
                    <td>{{ $report->cod_producto . '-' . $report->producto }}
                    </td>
                    <td>{{ $report->medida }}</td>
                    <td>{{ $report->bodega }}</td>
                    <td>{{ $report->localidad }}</td>
                    <td>{{ $report->dnivel }}</td>
                </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr>
                <td></td>
                <th>Fecha Movimiento</th>
                <td></td>
                <td></td>
                <th>Producto</th>
                <td></td>
                <th>Bodega</th>
                <th>Localidad</th>
                <th>Nivel</th>
            </tr>
        </tfoot>
        </thead>
    </table>
</section>
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
    ingresoMovimientoJs = new ingresoMovimiento();
    $(document).ready(function() {
        /*Inicializa funciones para el ingreso de movimiento*/
        ingresoMovimientoJs.funcionesInicial();
        /*Seteno de fecha por defecto*/
        var today = new Date();
        console.log(today);
        document.getElementById("fecha_movimiento").value = today.getFullYear() + '-' + ('0' + (today
                .getMonth() + 1))
            .slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        /*Fin Seteno de fecha por defecto*/
    });
</script>
{{-- <script>
    $(document).ready(function() {
        /*inicio codigo refere a la tabla*/
        $('#tblMovimiento tfoot th').each(function() {
            var title = $(this).text();
            $(this).html('<input type="text" placeholder="Search ' + title + '" />');
        });
        // DataTable
        var table = $('#tblMovimiento').DataTable({
            scrollY: 200,
            scrollX: true,
            order: [],
            lengthMenu: [
                [100, 125, 150, -1],
                [100, 125, 150, "All"]
            ],
            initComplete: function() {
                // Apply the search
                this.api().columns().every(function() {
                    var that = this;
                    $('input', this.footer()).on('keyup change clear', function() {
                        if (that.search() !== this.value) {
                            that
                                .search(this.value)
                                .draw();
                        }
                    });
                });
            }
        });
        /*fin codigo refere a la tabla*/
        /*inicio codigo refere al controlador de Cantidad*/
        function decrement(e) {
            e.preventDefault();
            const btn = e.target.parentNode.parentElement.querySelector(
                'button[data-action="decrement"]'
            );
            const target = btn.nextElementSibling;
            let value = Number(target.value);
            value--;
            target.value = value;
        }

        function increment(e) {
            e.preventDefault();
            const btn = e.target.parentNode.parentElement.querySelector(
                'button[data-action="decrement"]'
            );
            const target = btn.nextElementSibling;
            let value = Number(target.value);
            value++;
            target.value = value;
        }

        const decrementButtons = document.querySelectorAll(
            `button[data-action="decrement"]`
        );

        const incrementButtons = document.querySelectorAll(
            `button[data-action="increment"]`
        );

        decrementButtons.forEach(btn => {
            btn.addEventListener("click", decrement);
        });

        incrementButtons.forEach(btn => {
            btn.addEventListener("click", increment);
        });

        $('#id_categoria').change(function(e) {
            mode = e.value;
            console.log(mode);
        });
        /*fin codigo refere al controlador de Cantidad*/
        function cargaProductosCategoria(idCategoria) {
            $.ajax({
                'url': 'http://localhost:8000/books',
                'method': 'POST',
                'data': {
                    id: idCategoria
                },
                'success': function(data) {
                    agregarValorSelectProducto(data);
                }
            });
        }
        // Rutina para agregar opciones a un <select>
        function agregarValorSelectProducto(array) {
            var select = document.getElementsByName("id_producto")[0];
            for (value in array) {
                var option = document.createElement("option");
                option.text = array[value];
                select.add(option);
            }
        }
    });
</script> --}}
