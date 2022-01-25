@extends('layouts.head')

@section('body')
    <div class="mb-4 text-sm text-white">
        {{ __('Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.') }}
    </div>
    @if (session('status'))
        <div class="mb-4 font-medium text-sm text-green-600">
            {{ session('status') }}
        </div>
    @endif
    <form method="POST" action="{{ route('password.email') }}">
        @csrf
        <div class="block">
            <input type="email" id="email" class="block mt-1 w-full" name="email" :value="old('email')" required />
            <label class="form-label" for="form3Example3c">Your Email</label>
        </div>
        <div class="flex items-center justify-end mt-4">
            <input type="submit" name="submit" class="btn btn-primary btn-lg" value="Email Password Reset Link">
        </div>
    </form>
@endsection
