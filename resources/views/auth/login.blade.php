@extends('layouts.head')

@section('body')
    <div id="login">
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        @if (session('status'))
                            <div class="mb-4 font-medium text-sm text-black">
                                {{ session('status') }}
                            </div>
                        @endif
                        <form id="login-form" class="form" method="POST" action="{{ route('login') }}">
                            @csrf
                            <h3 class="text-center text-black">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-black">Email:</label><br>
                                <input id="email" class="form-control block mt-1 w-full" type="email" name="email"
                                    :value="old('email')" required autofocus>
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-black">Password:</label><br>
                                <input id="password" class="form-control block mt-1 w-full" type="password" name="password"
                                    required autocomplete="current-password">
                            </div>
                            <div class="form-group">
                                <label for="remember-me" class="text-black"><span>Remember me</span> <span><input
                                            id="remember-me" name="remember-me" type="checkbox"></span></label><br>
                                <input type="submit" name="submit" class="btn btn-info btn-md" value="submit">
                            </div>
                            <div id="register-link" class="text-right">
                                @if (Route::has('password.request'))
                                    <a class="underline text-sm text-gray-600 hover:text-gray-900"
                                        href="{{ route('password.request') }}">
                                        {{ __('Forgot your password?') }}
                                    </a>
                                @endif
                                <div>
                                    <a href="{{ route('register') }}"
                                        class="text-right underlinetext-sm text-gray-600 hover:text-gray-900">Register</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
