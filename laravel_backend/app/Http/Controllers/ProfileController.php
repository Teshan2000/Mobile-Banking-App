<?php

namespace App\Http\Controllers;

use App\Models\Profile;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function store(Request $R) {
        $R->validate([
            'name'=>'required|string|max:255',
            'profilePic'=>'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'telNumber'=>'nullable|string|max:10',
            'emailAddress'=>'required|string|max:255',
            'password'=>'required|string|max:8',
        ]);

        $profilePicPath = null;

        if($R->hasFile('profilePic')) {
            $profilePicPath = $R->file('profilePic')->store('profilePic', 'public');
        }

        $profile = Profile::create([
            'name'=>$R->name,
            'profilePic'=>$profilePicPath,
            'telNumber'=>$R->telNumber,
            'emailAddress'=>$R->emailAddress,
            'password'=>$R->password,
        ]);

        return response()->json(['statuus'=>200, 'message'=>'Profile saved successfully!', 'data'=>$profile]);
    }
}
