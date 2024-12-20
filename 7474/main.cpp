#include <Arduino.h>
int W, X, Y, Z;
int D, C, B, A;

void disp_7447(int D, int C, int B, int A) {
digitalWrite(2, A); // LSB
digitalWrite(3, B);
digitalWrite(4, C);
digitalWrite(5, D); // MSB
}

void setup() {
pinMode(2, OUTPUT);
pinMode(3, OUTPUT);
pinMode(4, OUTPUT);
pinMode(5, OUTPUT);
pinMode(6, INPUT);
pinMode(7, INPUT);
pinMode(8, INPUT);
pinMode(9, INPUT);
pinMode(13, OUTPUT);
}

void loop() {
// Display current state
digitalWrite(13, HIGH);
delay(100);
disp_7447(D, C, B, A);

// Read input switches
W = digitalRead(6);
X = digitalRead(7);
Y = digitalRead(8);
Z = digitalRead(9);

// Calculate next state
A = !W;
B = (!W && !X && Y) || (W && X) || (!W && Z);
C = (!W && Z) || (X && Y) || (W && Y);
D = (!W && !X && !Y && !Z) || (W && Z);

// Update current state with next state
W = A;
X = B;
Y = C;
Z = D;

// Turn off display and delay
digitalWrite(13, LOW);
delay(500);
}
