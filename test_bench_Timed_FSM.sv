////////////////////////////////////////////////////////////////////////////////////////////////////
// Design Name: Timed FSM Ex: Traffic Lights
// Engineer: kiran
// Reference: Synthesizable Finite State Machine Design Techniques by C.E Cummings(Sunburst Designs)
// Reference: https://verilogguide.readthedocs.io/en/latest/verilog/fsm.html
////////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps


module test_bench_Timed_FSM();

    //inputs to the DUT
        logic clk;
        logic rst;
    //outputs from the DUT
         logic Red;
         logic Yellow;
         logic Green;

         Timed_FSM DUT (.clk(clk),.rst(rst),.N_R(Red),.N_Y(Yellow),.N_G(Green));

         initial
            begin
                $display($time," << Simulation Results >> ");
                $monitor($time,"clk=%b, rst=%b, R=%b, Y=%b, G=%b",clk,rst,Red,Yellow,Green);
            end

         always #1 clk = ~clk;

         initial
            begin
                clk = 0;
                rst = 1;
                #5
                rst = 0;
                #160
                $finish;
            end
endmodule
