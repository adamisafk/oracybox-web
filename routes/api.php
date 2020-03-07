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

// middleware used to validate user oauth token
Route::group(['middleware' => 'auth:api'], function() {
    Route::get('/subjects', 'CurriculumController@getSubjects');
    Route::post('/topics', 'CurriculumController@getTopicsBySubjectId');
    Route::post('/activities', 'CurriculumController@getActivitiesByTopicId');

    Route::post('completed-activities/create', 'CompletedActivityController@createActivity');
    Route::get('completed-activities/list', 'CompletedActivityController@listActivities');
});

Route::post('user/register', 'UserController@registerUser');
Route::post('user/login', 'UserController@userLogin');

// Gets all users - TEMPORARY
Route::get('/users', function () {
    return \App\User::get();
});
