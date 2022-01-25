<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMovimientoInventariosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('movimiento_inventarios', function (Blueprint $table) {
            $table->id();
            $table->decimal('cantidad', 6, 2);
            $table->date('fecha_movimiento');
            $table->integer('lote');
            $table->unsignedBigInteger('id_producto');
            $table->unsignedBigInteger('id_medida');
            $table->unsignedBigInteger('id_bodega');
            $table->unsignedBigInteger('id_localidad');
            $table->unsignedBigInteger('id_tipo_movimiento');
            $table->unsignedBigInteger('nivel');
            $table->unsignedBigInteger('id_usuario_ing');
            $table->timestamps();
            $table->foreign('id_producto')->references('id')->on('productos');
            $table->foreign('id_medida')->references('id')->on('medidas');
            $table->foreign('id_bodega')->references('id')->on('bodegas');
            $table->foreign('id_localidad')->references('id')->on('localidades');
            $table->foreign('id_tipo_movimiento')->references('id')->on('tipo_movimientos');
            $table->foreign('nivel')->references('id')->on('niveles');
            $table->foreign('id_usuario_ing')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('movimiento_inventarios');
    }
}
