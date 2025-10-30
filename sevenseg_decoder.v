// EECS 3201 – Lab 2
// Seven-Segment Decoder (Active-Low) for DE10-Lite
// Author: Shivam Gupta [219923309]
// ----------------------------------------------------
// This module takes a 4-bit binary input (from SW3–SW0)
// and displays the corresponding hexadecimal digit (0–F)
// on the rightmost seven-segment display (HEX0).
//
// Board notes:
// • HEX0 segments (a–g) are active-low → 0 = ON, 1 = OFF
// • Only HEX0 lights up
// ----------------------------------------------------

module sevenseg_decoder (
    input  [3:0] hex,   // Switch input (SW3..SW0)
    output [6:0] seg    // HEX0 segments (a–g)
);

    // ------------------------------------------------
    // Each segment’s Boolean function (active-high form
    // ------------------------------------------------
    wire [6:0] seg_raw;


	// seg[0] (top): ON for 0,2,3,5,6,7,8,9,A,C,E,F  (OFF for 1,4,B,D)
	assign seg_raw[0] = (~hex[3]&~hex[2]&~hex[1]&~hex[0]) |  // 0
                    (~hex[3]&~hex[2]& hex[1]&~hex[0]) |  // 2
                    (~hex[3]&~hex[2]& hex[1]& hex[0])  |  // 3
                    (~hex[3]& hex[2]&~hex[1]& hex[0])  |  // 5
                    (~hex[3]& hex[2]& hex[1]&~hex[0])  |  // 6
                    (~hex[3]& hex[2]& hex[1]& hex[0])  |  // 7
                    ( hex[3]&~hex[2]&~hex[1]&~hex[0])  |  // 8
                    ( hex[3]&~hex[2]&~hex[1]& hex[0])  |  // 9
                    ( hex[3]&~hex[2]& hex[1]&~hex[0])  |  // A
                    ( hex[3]& hex[2]&~hex[1]&~hex[0])  |  // C
                    ( hex[3]& hex[2]& hex[1]&~hex[0])  |  // E
                    ( hex[3]& hex[2]& hex[1]& hex[0]);    // F

    // Segment 1 (top-right): ON for 0,1,2,3,4,7,8,9,A,D
    assign seg_raw[1] = (~hex[3]&~hex[2]&~hex[1]&~hex[0]) | (~hex[3]&~hex[2]&~hex[1]& hex[0]) |
                        (~hex[3]&~hex[2]& hex[1]&~hex[0]) | (~hex[3]&~hex[2]& hex[1]& hex[0]) |
                        (~hex[3]& hex[2]&~hex[1]&~hex[0]) | (~hex[3]& hex[2]& hex[1]& hex[0]) |
                        ( hex[3]&~hex[2]&~hex[1]&~hex[0]) | ( hex[3]&~hex[2]&~hex[1]& hex[0]) |
                        ( hex[3]&~hex[2]& hex[1]&~hex[0]) | ( hex[3]& hex[2]&~hex[1]& hex[0]);

	// seg[2] (bottom-right): ON for 0,1,3,4,5,6,7,8,9,A,B,D (OFF for 2,C,E,F)
	assign seg_raw[2] = (~hex[3]&~hex[2]&~hex[1]&~hex[0]) |  // 0
								  (~hex[3]&~hex[2]&~hex[1]& hex[0]) |  // 1
								  (~hex[3]&~hex[2]& hex[1]& hex[0])  |  // 3
								  (~hex[3]& hex[2]&~hex[1]&~hex[0])  |  // 4
								  (~hex[3]& hex[2]&~hex[1]& hex[0])  |  // 5
								  (~hex[3]& hex[2]& hex[1]&~hex[0])  |  // 6
								  (~hex[3]& hex[2]& hex[1]& hex[0])  |  // 7
								  ( hex[3]&~hex[2]&~hex[1]&~hex[0])  |  // 8
								  ( hex[3]&~hex[2]&~hex[1]& hex[0])  |  // 9
								  ( hex[3]&~hex[2]& hex[1]&~hex[0])  |  // A
								  ( hex[3]&~hex[2]& hex[1]& hex[0])  |  // B
								  ( hex[3]& hex[2]&~hex[1]& hex[0]);    // D

    // Segment 3 (bottom): ON for 0,2,3,5,6,8,9,B,C,D,E
    assign seg_raw[3] = (~hex[3]&~hex[2]&~hex[1]&~hex[0]) | (~hex[3]&~hex[2]& hex[1]&~hex[0]) |
                        (~hex[3]&~hex[2]& hex[1]& hex[0]) | (~hex[3]& hex[2]&~hex[1]& hex[0])  |
                        (~hex[3]& hex[2]& hex[1]&~hex[0]) | ( hex[3]&~hex[2]&~hex[1]&~hex[0]) |
                        ( hex[3]&~hex[2]&~hex[1]& hex[0]) | ( hex[3]&~hex[2]& hex[1]& hex[0])  |
                        ( hex[3]& hex[2]&~hex[1]&~hex[0]) | ( hex[3]& hex[2]&~hex[1]& hex[0])  |
                        ( hex[3]& hex[2]& hex[1]&~hex[0]);

    // Segment 4 (bottom-left): ON for 0,2,6,8,A,B,C,D,E,F
    assign seg_raw[4] = (~hex[3]&~hex[2]&~hex[1]&~hex[0]) | (~hex[3]&~hex[2]& hex[1]&~hex[0]) |
                        (~hex[3]& hex[2]& hex[1]&~hex[0])  | ( hex[3]&~hex[2]&~hex[1]&~hex[0]) |
                        ( hex[3]&~hex[2]& hex[1]&~hex[0])  | ( hex[3]&~hex[2]& hex[1]& hex[0]) |
                        ( hex[3]& hex[2]&~hex[1]&~hex[0])  | ( hex[3]& hex[2]&~hex[1]& hex[0]) |
                        ( hex[3]& hex[2]& hex[1]&~hex[0])  | ( hex[3]& hex[2]& hex[1]& hex[0]);

    // Segment 5 (top-left): ON for 0,4,5,6,8,9,A,B,C,E,F
    assign seg_raw[5] = (~hex[3]&~hex[2]&~hex[1]&~hex[0]) | (~hex[3]& hex[2]&~hex[1]&~hex[0]) |
                        (~hex[3]& hex[2]&~hex[1]& hex[0])  | (~hex[3]& hex[2]& hex[1]&~hex[0])  |
                        ( hex[3]&~hex[2]&~hex[1]&~hex[0])  | ( hex[3]&~hex[2]&~hex[1]& hex[0]) |
                        ( hex[3]&~hex[2]& hex[1]&~hex[0])  | ( hex[3]&~hex[2]& hex[1]& hex[0])  |
                        ( hex[3]& hex[2]&~hex[1]&~hex[0])  | ( hex[3]& hex[2]& hex[1]&~hex[0])  |
                        ( hex[3]& hex[2]& hex[1]& hex[0]);

 // ------------------------------------------------
    // Segment 6 (middle): ON for 2,3,4,5,6,8,9,A,B,D,E,F
    // ------------------------------------------------
    // Canonical SOP form (from truth table):
    // seg[6] = Σm(2,3,4,5,6,8,9,10,11,13,14,15)
    //
    // Algebraic Reduction (K-map simplification):
    //   seg[6] = (x2 & ~x1) | (x3 & ~x0) | (~x3 & x1) | (x2 & x0)
    //
    // Explanation:
    //   • Grouped minterms with common variables in a 4-variable K-map.
    //   • Each term represents one adjacency group of 1s.
    //   • This eliminates redundant product terms, producing a minimal SOP form.
    //
    // Final simplified expression used below (x3=x[3], x2=x[2], x1=x[1], x0=x[0]):
assign seg_raw[6] = (~hex[3]&~hex[2]& hex[1]&~hex[0]) |  // 2
                    (~hex[3]&~hex[2]& hex[1]& hex[0])  |  // 3
                    (~hex[3]& hex[2]&~hex[1]&~hex[0])  |  // 4
                    (~hex[3]& hex[2]&~hex[1]& hex[0])  |  // 5
                    (~hex[3]& hex[2]& hex[1]&~hex[0])  |  // 6
                    ( hex[3]&~hex[2]&~hex[1]&~hex[0])  |  // 8
                    ( hex[3]&~hex[2]&~hex[1]& hex[0])  |  // 9
                    ( hex[3]&~hex[2]& hex[1]&~hex[0])  |  // A
                    ( hex[3]&~hex[2]& hex[1]& hex[0])  |  // B
                    ( hex[3]& hex[2]&~hex[1]& hex[0])  |  // D
                    ( hex[3]& hex[2]& hex[1]&~hex[0])  |  // E
                    ( hex[3]& hex[2]& hex[1]& hex[0]);    // F



    // ------------------------------------------------
    // Convert to active-low (0 = ON) for DE10-Lite HEX0
    // ------------------------------------------------
    assign seg = ~seg_raw;

endmodule