
;using assembly language for turning LED on


.include "/sdcard/DD/digital-design/assembly/setup/m328Pdef/m328Pdef.inc"




; Assembly code for 2-input NAND gate on Arduino Uno (ATmega328P)
; Inputs: PORTD2 and PORTD3 (pins 2 and 3 on Arduino Uno)
; Output: PORTB5 (pin 13 on Arduino Uno)

.include "/sdcard/DD/digital-design/assembly/setup/m328pdef/m328Pdef.inc"

; Define bit masks for the input and output pins
.equ INPUT_MASK = (1 << PD2) | (1 << PD3) ; Mask for PD2 and PD3 as inputs
.equ OUTPUT_MASK = (1 << PB5)             ; Mask for PB5 as output

; Initialize the I/O settings
.org 0x00                    ; Start at address 0
    rjmp start               ; Jump to the start of the program

start:
    ; Set up PORTB and PORTD pins
    ldi r16, OUTPUT_MASK     ; Load the output bit mask for PB5 (PIN13)
    out DDRB, r16            ; Set PB5 as output (others default to input)
    
    ; Set PORTD2 and PORTD3 as inputs
    ; No need to explicitly set DDRD bits 2 and 3 to 0, as they're inputs by default
    ldi r16, 0x00
    out DDRD, r16

main:
    ; Read inputs from PORTD
    in r17, PIND             ; Read the current state of PORTD into r17

    ; Check if both inputs (PD2 and PD3) are high (1)
    mov r18, r17             ; Copy PORTD value to r18
    andi r18, INPUT_MASK     ; Mask to keep only PD2 and PD3 values
    cpi r18, INPUT_MASK      ; Compare masked value with INPUT_MASK (both high)

    ; If both inputs are high, output LOW for NAND (0)
    breq output_low          ; Branch to output_low if both inputs are high

    ; If either input is low, output HIGH for NAND (1)
output_high:
    sbi PORTB, PB5           ; Set PB5 high (turn LED on)
    rjmp main                ; Repeat the loop

output_low:
    cbi PORTB, PB5           ; Set PB5 low (turn LED off)
    rjmp main                ; Repeat the loop
