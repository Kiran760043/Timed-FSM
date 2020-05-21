////////////////////////////////////////////////////////////////////////////////////////////////////
// Design Name: Timed FSM Ex: Traffic Lights
// Engineer: kiran
// Reference: Synthesizable Finite State Machine Design Techniques by C.E Cummings(Sunburst Designs)
// Reference: https://verilogguide.readthedocs.io/en/latest/verilog/fsm.html
////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps


module Timed_FSM(clk,rst,N_R,N_Y,N_G);

    input  logic clk;
    input  logic rst;
    output logic N_R;
    output logic N_Y;
    output logic N_G;

    logic R;
    logic Y;
    logic G;

    typedef enum logic[1:0] {red, yellow, green} color;
    color state,nxt_state;

    logic Scount;

    logic [3:0]count;

    always@(posedge clk, posedge rst)
        begin
            if(rst)
                state <= red;
            else
                state <= nxt_state;
        end

    always@(posedge clk, posedge rst)
        begin
            if(rst | ~Scount) begin
                count <= 0;
            end else begin
                if(Scount)
                    count <= count + 1;
                end
        end

     always@(count)
        begin

            nxt_state <= state;

            case(state)
                red   : begin
                            R <= 1;
                            Y <= 0;
                            G <= 0;
                            if(count == 8) begin
                                nxt_state <= yellow;
                                Scount    <= 0;
                            end else begin
                                nxt_state <= red;
                                Scount    <= 1;
                            end
                        end
                yellow: begin
                            R <= 0;
                            Y <= 1;
                            G <= 0;
                            if(count == 4) begin
                                nxt_state <= green;
                                Scount    <= 0;
                            end else begin
                                nxt_state <= yellow;
                                Scount    <= 1;
                            end
                        end
                green : begin
                            R <= 0;
                            Y <= 0;
                            G <= 1;
                            if(count == 10) begin
                                nxt_state <= red;
                                Scount    <= 0;
                            end else begin
                                nxt_state <= green;
                                Scount    <= 1;
                            end
                        end
             endcase
        end



////////////////////////////////////////////////////// Optional D-FF to eliminate Glitches
     always@(posedge clk, posedge rst)
        begin
            if(rst) begin
                N_R <= 0;
                N_Y <= 0;
                N_G <= 0;
            end else begin
                N_R <= R;
                N_Y <= Y;
                N_G <= G;
            end
        end


endmodule
