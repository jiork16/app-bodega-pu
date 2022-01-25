<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sistema Movimiento de Inventario</title>
    <script src="{{ asset('js/jquery-3.5.1.js') }}"></script>
    <link rel="stylesheet" href="{{ asset('css/main.css') }}">
    <link rel="stylesheet" href="{{ asset('css/bootstrap.css') }}">
    <link rel="stylesheet" href="{{ asset('css/dataTables.bootstrap4.min.css') }}">
    {{-- <link rel="stylesheet" href="{{ asset('css/dataTables.bootstrap.min.css') }}"> --}}
    <link rel="stylesheet" href="{{ asset('css/jquery.dataTables.min.css') }}">
    <link rel="stylesheet" href="{{ asset('css/sweetalert2.min.css') }}">
    {{-- <link rel="stylesheet" href="{{ asset('css/flowbite.min.css') }}"> --}}
    <link rel="stylesheet" href="{{ asset('css/mdb.min.css') }}">
    <script src="{{ asset('js/main.js') }}"></script>
    <script src="{{ asset('js/bootstrap.js') }}"></script>
    <script src="{{ asset('js/jquery.dataTables.min.js') }}"></script>
    <script src="{{ asset('js/dataTables.bootstrap4.min.js') }}"></script>
    <script src="{{ asset('js/sweetalert2.all.min.js') }}"></script>
    {{-- <script src="{{ asset('js/mdb.min.js') }}"></script> --}}
    {{-- <script src="{{ asset('js/flowbite.bundle.js') }}"></script> --}}
</head>

<body>
    <div x-data="{ sidebarOpen: false }" class="flex h-screen bg-gray-200 font-roboto">
        @include('layouts.sidebar')

        <div class="flex-1 flex flex-col overflow-hidden">
            @include('layouts.header')

            <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-200">
                <div class="container mx-auto px-6 py-9">
                    @yield('body')
                </div>
            </main>
        </div>
    </div>
</body>
<script src="{{ asset('js/mdb.min.js') }}"></script>

</html>
