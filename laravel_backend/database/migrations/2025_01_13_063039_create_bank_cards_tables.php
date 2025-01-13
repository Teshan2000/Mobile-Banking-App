<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bank_cards', function (Blueprint $table) {
            $table->id();
            $table->string('accHolder');
            $table->string('accNumber');
            $table->string('cvvNumber', 3);
            $table->date('expDate');
            $table->string('bankName');
            $table->enum('cardType', ['Master', 'Visa', 'Paypal', 'GooglePay', 'ApplePay', 'Helapay']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bank_cards');
    }
};
