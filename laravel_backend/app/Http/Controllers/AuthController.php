<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;

class AuthController extends Controller
{
    function Register(Request $R) {
        try {
            $cred = new User();
            $cred->name = $R->name;
            $cred->email = $R->email;
            $cred->password = Hash::make($R->password);
            $cred->save();

            $response = ['status' => 200, 'message' => "Registration Successful!"];
            return response()->json($response);

        } catch(Exception $e) {
            $response = ['status' => 500, 'message' => $e];
            return response()->json($response);
        }
    }

    function Login(Request $R) {
        $user = User::where('email', $R->email)->first();

        if($user && Hash::check($R->password, $user->password)) {
            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response = ['status' => 200, 'token' => $token, 'user' => $user, 'message' => "Login Successful!"];
            return response()->json($response);
        }
        else{
            $response = ['status' => 500, 'message' => "No account found with this email or wrong password"];
            return response()->json($response);
        }
    }

    function ForgotPassword(Request $R) {
        $R->validate(['email' => 'required|email']);

        $status = Password::sendResetLink($R->only('email'));

        return $status === Password::RESET_LINK_SENT 
            ? response()->json(['status' => 200, 'message' => 'Reset link sent successfully!']) 
            : response()->json(['status' => 500, 'message' => 'Unable to send reset link!']);
    }

    function ResetPassword(Request $R) {
        $R->validate([
            'token' => 'required',
            'email' => 'required|email',
            'password' => 'required|min:8|confirmed',
        ]);

        $status = Password::reset(
            $R->only('email', 'password', 'password_confirmation', 'token'),
            function($user, $password) {
                $user->forceFill([
                    'password' => Hash::make($password),
                ])->save();
            }
        );

        return $status === Password::PASSWORD_RESET 
            ? response()->json(['status' => 200, 'message' => 'Password reset successfully!']) 
            : response()->json(['status' => 500, 'message' => 'Unable to reset password!']);
    }
}
