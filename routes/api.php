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
Route::get('/users', function () {
    return \App\User::get();
});

Route::get('/completed/class/{classroom}', 'ApiController@showCompletedActivityByClassroom');
Route::get('/completed/id/{activity}', 'ApiController@showResultsByCompletedActivityId');
