// EECS 3201 – Lab 3: 4-bit Adder/Subtractor with Carry/Sign Display
// Author: Shivam Gupta [219923309]

module lab3_top (
    input  [9:0] SW,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    // -------------------- Inputs --------------------
    wire [3:0] A = SW[3:0];   // a0
    wire [3:0] B = SW[7:4];   // a1
    wire       s = SW[8];     // 0 = add, 1 = subtract

    // -------------------- Arithmetic --------------------
    wire [3:0] SUM;
    wire       cout;
    adder_sub_4bit U_ADD (A,B,s,SUM,cout);

    // -------------------- Output formatting --------------------
    wire [3:0] mag;       // magnitude for display
    assign mag = (s && !cout) ? (~SUM + 1) : SUM;
    // if subtraction and negative → undo 2's complement

    // Decode digits
    wire [6:0] segA, segB, segR, segOne, segMinus;
    sevenseg_decoder H_A (A,   segA);
    sevenseg_decoder H_B (B,   segB);
    sevenseg_decoder H_R (mag, segR);

    // Constant patterns
    assign segOne   = 7'b1111001;  // “1”
    assign segMinus = 7'b0111111;  // “–”
    assign HEX2 = 7'b1111111;
    assign HEX4 = 7'b1111111;

    // -------------------- Display logic --------------------
    assign HEX5 = segA;   // show A
    assign HEX3 = segB;   // show B
    assign HEX0 = segR;   // result digit

    // HEX1 behaviour (carry / sign)
    assign HEX1 = (s==0) ?                      // ADDITION
                    (cout ? segOne : 7'b1111111) :
                  (s==1) ?                      // SUBTRACTION
                    (cout ? 7'b1111111 : segMinus) :
                    7'b1111111;
endmodule
