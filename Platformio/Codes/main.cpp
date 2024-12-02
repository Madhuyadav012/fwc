#include <Arduino.h>
const int A_pin = 2;
const int B_pin = 3;
const int output_pin = 13;

void setup() {
  pinMode(A_pin, INPUT);
  pinMode(B_pin, INPUT);
  pinMode(output_pin, OUTPUT);
}

void loop() {
  int A = digitalRead(A_pin);
  int B = digitalRead(B_pin);

  // Implement NAND gate
  int nand_output = !(A && B);

  digitalWrite(output_pin, nand_output);
}
