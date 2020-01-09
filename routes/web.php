<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});

Route::get('/', 'BlogController@index');
Route::get('post/{slug}', 'BlogController@show');
Route::get('contact', function() {
    return view('contact');
});
Route::get('{slug}', 'PagesController@show');
