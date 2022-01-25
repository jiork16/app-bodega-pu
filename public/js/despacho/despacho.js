function despacho(){
    this.funcionesInicial=funcionesInicial;
    this.btnDespachar=btnDespachar;
    let table;
    /** FUNCIONES QUE SE INICIALIZAN CON AL CARGAR LA PANTALL */
    function funcionesInicial(){    // Setup - add a text input to each footer cell
        $('#tblDespacho tfoot th').each(function() {
            var title = $(this).text();
            $(this).html('<input type="text" placeholder="Buscar" />');
        });
        // DataTable
        table = $('#tblDespacho').DataTable({
            fixedHeader: {
                header: true,
                footer: true
            },
            fixedColumns: {
                left: 2,
                right: 1
            },
            bScrollCollapse: true,
            scrollY: 200,
            scrollX: true,
            order: [
                [2, "asc"]
            ],
            columnDefs: [{
                    targets: [0],
                    visible: false,
                    searchable: false
                },
                {
                    targets: [2],
                    className: "text-center",
                    width: "4%"
                },
                {
                    targets: [3],
                    className: "text-center",
                    width: "10%"
                }
            ],
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
        $("#tblDespacho tbody").on('click', '#btnDespachar', function() {
            if ( $(this).closest('tr').hasClass('selected') ) {
                $(this).closest('tr').removeClass('selected');
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).closest('tr').addClass('selected');
            }
            setValDespachar(table.row('.selected').data());
            console.log(table.row('.selected').data());
            //btnDespachar( $(this).closest('tr').prevAll().length);
            //btnDespachar(table.row( this ).data())
        });
        $("#btnGuardarDespacho").on('click', function(e) {
            e.preventDefault();
            const cantTotal= +document.getElementById('cant_ant').value;
            const cantDespachar = +document.getElementById("cantidad").value;
            if ((cantDespachar > cantTotal ) || (cantTotal<=0)) {
                alertaSweet('Error!',"No se puede Despachar una cantidad mayor a la existente ",'error');
            }
            postDescpacho();
        });
    }
    /** INICIO CORRESPONDIENTE AL CONTROLADOR DE PRODUCTO */
    function postDescpacho() {
        let datos= $('#formMovimiento').serialize();
        const url= $('#formMovimiento').attr('action');
        datos = datos+"&id_movimiento="+document.getElementById("btnGuardarDespacho").value;
        $.ajax({
            type    : 'POST',
            url     : url,
            data    : datos,
            dataType: 'json',
            encode  : true,
            success: function(object) {
                alertaSweet('Success!',object.message,'success');
                document.getElementById("cant_ant").value = 0;
                //$('#modalValor').modal('toggle')
                window.location.href = '/despacho';
            },
            error: function( jqXHR, textStatus, errorThrown ) {
                let mensaje='';
                switch (jqXHR.status) {
                    case 0:
                        mensaje='Not connect: Verify Network.';
                        break;
                    case 404:
                        mensaje='Requested page not found [404]';
                        break;
                    case 500:
                        mensaje='Internal Server Error [500].';
                        break;
                    default:
                        if (textStatus === 'parsererror') {
                            mensaje='Requested JSON parse failed.';
                        } else if (textStatus === 'timeout') {
                            mensaje='Time out error.';
                        } else if (textStatus === 'abort') {
                            mensaje='Ajax request aborted.';
                        } else {
                            mensaje='Uncaught Error: ' + jqXHR.responseText;
                        }
                        break;
                }
                alertaSweet('Error!',mensaje,'error');
            }
          });
    }
    /** INICIO CORRESPONDIENTE AL CONTROLADOR DE PRODUCTO */
    function setValDespachar(arrayVal) {
        $("#lote").val(arrayVal[2]);
        $("#categoria").val(arrayVal[3]);
        $("#id_producto").val(arrayVal[4]);
        $("#producto").val(arrayVal[5]);
        $("#id_medida").val(arrayVal[6]);
        $("#id_bodega").val(arrayVal[7]);
        $("#id_localidad").val(arrayVal[8]);
        $("#nivel").val(arrayVal[9]);
        $("#id_movimiento").val(arrayVal[0]);
        $("#cant_ant").val(arrayVal[10]);
        $("#btnGuardarDespacho").val(arrayVal[0]);
        console.log(document.getElementById('btnGuardarDespacho').value);
    }
    function alertaSweet(titulo,mensaje,icono) {
        Swal.fire({
            title: titulo,
            text:   mensaje,
            icon:   icono,
            confirmButtonText: 'Ok'
        });
    }

}
