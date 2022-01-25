{{-- <!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
<!-- MDB -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet" /> --}}
<!-- MDB -->
<section class="p-6 mx-auto bg-white rounded-md shadow-md dark:bg-gray-800 mt-auto">
    <table id="tblStock" class="stripe display compact table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
                <th>#</th>
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
            @foreach ($dataStock as $stock)
                <tr>
                    <td>{{ $stock->id }}</td>
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
                <th>Lote</th>
                <th>Categoria</th>
                <th>CodProducto</th>
                <th>Producto</th>
                <th>Medida</th>
                <th>Bodega</th>
                <th>Localidad</th>
                <th>Nivel</th>
                <td>Total</td>
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
<script>
    $(document).ready(function() {
        // Setup - add a text input to each footer cell
        $('#tblStock tfoot th').each(function() {
            var title = $(this).text();
            $(this).html('<input type="text" placeholder="Search ' + title + '" />');
        });
        // DataTable
        var table = $('#tblStock').DataTable({
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

    });
</script>
