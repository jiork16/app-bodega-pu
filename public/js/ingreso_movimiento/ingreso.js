function ingresoMovimiento(){
    this.funcionesInicial=funcionesInicial;
    /** FUNCIONES QUE SE INICIALIZAN CON AL CARGAR LA PANTALL */
    function funcionesInicial(){
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
        cargaProductosCategoria(document.getElementById("id_categoria").value);
        $('#id_categoria').change(function(e) {
            idCategoria = document.getElementById("id_categoria").value;
			cargaProductosCategoria(idCategoria);
        });
    }
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
    /*fin codigo refere al controlador de Cantidad*/
    /** INICIO CORRESPONDIENTE AL CONTROLADOR DE PRODUCTO */
    function cargaProductosCategoria(idCategoria) {
        $.ajax({
            type    : 'GET',
            url     :`productos/${idCategoria}`,
            dataType: 'json',
            encode  : true,
            success: function(objet) {
                agregarValorSelectProducto(objet);
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
    // Rutina para agregar opciones a un <select>
    function agregarValorSelectProducto(objet) {
        limpiarControladorSelectProductos();
        var $select = document.querySelector("#id_producto");
        var option;
        objet['data'].map(function(datos) {
            option = document.createElement('option');
            option.value = datos.id;
            option.text =  datos.cod_producto+'-'+datos.descripcion;
            $select.appendChild(option);
        });
    }
     // Rutina para limpiar las opciones opciones a un <select>
    function limpiarControladorSelectProductos() {
        var select = document.getElementById("id_producto");
        var length = select.options.length;
        for (i = length-1; i >= 0; i--) {
          select.options[i] = null;
        }
    }
    /** INICIO CORRESPONDIENTE AL CONTROLADOR DE PRODUCTO */
    function alertaSweet(titulo,mensaje,icono) {
        Swal.fire({
            title: titulo,
            text:   mensaje,
            icon:   icono,
            confirmButtonText: 'Ok'
        });
    }
}
