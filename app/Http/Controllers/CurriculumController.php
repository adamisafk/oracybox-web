<?php

namespace App\Http\Controllers;

use App\Subject;
use App\Topic;
use App\Activity;
use http\Env\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CurriculumController extends Controller
{
    public function getSubjects() {
        $subjects = Subject::all();
        return response()->json($subjects);
    }


    public function getTopicsBySubjectId(Request $request) {
        $validator = Validator::make($request->all(), [
            'subject_id' => 'required'
        ]);
        if($validator->fails()) {
            return response()->json([
                'validation_errors' => $validator->errors()
            ]);
        }
        if($validator->fails()) {
            return back()->withErrors($validator->errors());
        } else {
            $topics = Topic::where('subject_id', $request->subject_id)->get();
            return response()->json($topics);
        }
    }


    public function getActivitiesByTopicId(Request $request) {
        $validator = Validator::make($request->all(), [
                'topic_id' => 'required'
            ]);
        if($validator->fails()) {
            return response()->json([
                "validation_errors" => $validator->errors()
            ]);
        }
        if($validator->fails()) {
            return back()->withErrors($validator->errors());
        } else {
            $activities = Activity::where('topic_id', $request->topic_id)->get();
            return response()->json($activities);
        }
    }
}
