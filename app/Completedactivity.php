<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Completedactivity extends Model
{
    //mass assignment
    protected $fillable = [
        'activity_id', 'pupil_id', 'classroom_id','results', 'media_path'
    ];
}
