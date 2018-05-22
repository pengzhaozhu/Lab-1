/* Lab 1 Part C
   Name: Pengzhao Zhu
   Section#: 112D
   TA Name: Chris Crary
   Description: This program filters a table in program memory according the several conditions and put the filtered 
                data into data memory
*/

.include "ATxmega128A1Udef.inc"  ;according the Schwartz. The new board/program doesn't need this anymore
.list 

.org 0x0000   ;start at address 0x000
	rjmp MAIN ;jump to main code

.org 0xC000  ;location to put the table

Table: .db 0b01111000, 0x79, 0123, 0b00100000, 108, '7', 'v', 0b01111110, 040, 0x69, '9' ,0x78, 0b01110001, 122, 0 ; initialize table

.dseg  ;changing to data memory because this is the place where we will put our filtered table
.org  0x3744   ;where we will start putting the table

filtable: .byte 15   ;reserve a byte. will use pointer to increment this table.

.cseg    ;node the code segment
.org 0x200  ;a place where we will put our executable code
MAIN:

ldi YL, low(filtable)  ;Y pointer point to where the table will start
ldi YH, high(filtable) ;low and high bytes

;look at the byte 0x18000
ldi ZL, byte3(Table<<1) ;look at 0x01.  load byte3 into ZL
sts CPU_RAMPZ, ZL       ;put address pointed by ZL into CPU_RAMPZ
ldi ZL, low(Table << 1)        ; look at 0x00
ldi ZH, high(Table << 1)       ; look at 0x80

THIRD:
elpm r16, Z+                ;store the value at concavated RAMPZ + Z pointer to r16, then increment z point

ldi r20, 0  ;load r10 with 0. The null character is 0
cp r16, r20 ;check if r16 is 0
breq DOWN  ; branch to DOWN if equal. In other word, that is the null character, we need to stop

bst r16, 6 ; store bit 6 of r16 into the T flag
brts BITSET  ; branch if the bit is set
brtc TCLEAR  ; branch if the bit is clear 

BITSET: 
 cpi r16, 0x79 ;compare value in r16 with 0x79
 brlo SUBTRACT  ;branch if value in r16 is less than 0x79
 rjmp THIRD     ;back on top

 SUBTRACT:
 subi r16,3   ;subtract 3 from r16
  rjmp STOR   ;jump

TCLEAR:
cpi r16, 37          ; check is r16 is less than 37. if it is, go to store
brlo STOR    ;branch to STOR
rjmp THIRD   ;back to THIRD


  STOR:
  st Y+, r16   ;store value in r16 to address pointed by Y pointer. post increment Y pointer
  rjmp THIRD   ;back on top

  DOWN:
  st Y, r16 ;store the value in r16 to the place pointed by Y pointer
  DONE:
  	rjmp DONE    ;infinite loop to end the program
