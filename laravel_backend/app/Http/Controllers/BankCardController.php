<?php

namespace App\Http\Controllers;

use App\Models\BankCard;
use Illuminate\Http\Request;

class BankCardController extends Controller
{
    public function storeCard(Request $R) 
    {
        $R->validate([
            'accHolder' => 'required|string|max:255',
            'accNumber' => 'required|string|unique:bank_cards|max:20',
            'cvvNumber' => 'required|string|max:3',
            'expDate' => 'required|date',
            'bankName' => 'required|string|max:255',
            'cardType' => 'required|in:Master,Visa,Paypal,GooglePay,ApplePay,Helapay',
        ]);

        $card = BankCard::create([
            'accHolder' => $R->accHolder,
            'accNumber' => $R->accNumber,
            'cvvNumber' => $R->cvvNumber,
            'expDate' => $R->expDate,
            'bankName' => $R->bankName,
            'cardType' => $R->cardType,
        ]);

        return response()->json(['status' => 200, 'message' => 'Card added successfully!', 'data' => $card]);
    }

    public function fetchCard() 
    {
        $cards = BankCard::all();
        return response()->json(['status' => 200, 'message' => 'Cards fetched successfully!', 'data' => $cards]);
    }
}
