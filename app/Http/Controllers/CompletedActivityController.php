<?php

namespace App\Http\Controllers;

use App\Completedactivity;
use App\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CompletedActivityController extends Controller
{
    public function createActivity(Request $request) {
        //validate input
        $validator = Validator::make($request->all(), [
            'activity_id' => 'required',
            'results' => 'required'
        ]);
        if($validator->fails()) {
            return response()->json(["validation errors" => $validator->errors()]);
        }

        //Retrieve user with auth access token
        $user = Auth::user();

        if($validator->fails()) {
            return back()->withErrors($validator->errors());
        } else {
            $input = array(
                'activity_id' => $request->activity_id,
                'pupil_id' => $user->id,
                'classroom_id' => User::find($user->id)->classroom_id,
                'results' => $request->results,
                'media_path' => $request->media_path,
            );
            $activity = Completedactivity::create($input);
        }
        return response()->json(["success" => true, "data" => $activity]);
    }

    public function listActivities() {
        //Retrieve user with auth access token
        $user = Auth::user();

        //Listing completed activities using user id
        $activities = Completedactivity::where('pupil_id', $user->id)->get();

        return response()->json(["success" => true, "data" => $activities]);
    }
}
