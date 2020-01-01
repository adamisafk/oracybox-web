<?php

namespace App\Http\Controllers;

use App\Completedactivity;
use Illuminate\Http\Request;

class ApiController extends Controller
{
    public function showCompletedActivityByClassroom($classroom) {
        return Completedactivity::where('classroom_id', $classroom)->latest()->get();
    }
    public function showResultsByCompletedActivityId($activity) {
        return Completedactivity::where('id', $activity)->get(['results']);
    }
}
