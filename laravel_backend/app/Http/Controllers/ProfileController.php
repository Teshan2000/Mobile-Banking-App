<?php

namespace App\Http\Controllers;

use App\Models\Profile;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function store(Request $request)
    {
        // Validate incoming data
        $validatedData = $request->validate([
            'name' => 'nullable|string|max:255',
            'profilePic' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'telNumber' => 'nullable|string|max:10',
            'emailAddress' => 'nullable|string|max:255',
            'password' => 'nullable|string|max:8',
        ]);

        // Handle file upload if present
        $profilePicPath = null;
        if ($request->hasFile('profilePic')) {
            $profilePicPath = $request->file('profilePic')->store('profilePic', 'public');
        }

        // Save data to the database
        $profile = Profile::create(array_merge($validatedData, ['profilePic' => $profilePicPath]));

        return response()->json(['message' => 'Profile saved successfully!', 'data' => $profile], 200);
    }

    public function fetch()
    {
        $profiles = Profile::all();
        return response()->json(['success' => true, 'data' => $profiles], 200);
    }
}
