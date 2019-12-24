<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

// Gets all users
Route::get('/users/all', function () {
    return \App\User::get();
});

//Gets all pupil users
Route::get('/pupils/all', function () {
    return \App\User::where('role_id', 3)->get();
});
