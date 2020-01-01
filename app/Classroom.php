<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Traits\Translatable;

class Classroom extends Model
{
    use Translatable;

    protected $translatable = ['slug', 'name'];

    protected $table = 'classrooms';

    protected $fillable = ['slug', 'name'];

    public function classrooms()
    {
        return $this->hasMany(Voyager::modelClass('Classroom'))
            ->orderBy('created_at', 'DESC');
    }
}
