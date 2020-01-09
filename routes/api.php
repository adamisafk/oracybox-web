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

Route::group(['middleware' => 'auth:api'], function() {
    Route::post('completed-activities/create', 'CompletedActivityController@createActivity');
    Route::get('completed-activities/list', 'CompletedActivityController@listActivities');
});

Route::post('user/register', 'UserController@registerUser');
Route::post('user/login', 'UserController@userLogin');

// Gets all users
Route::get('/users', function () {
    return \App\User::get();
});
