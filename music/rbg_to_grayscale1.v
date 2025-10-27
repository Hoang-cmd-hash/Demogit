`timescale 1ns / 1ps


module rgbtogray(
    input clk,        
    input reset_n,    
    input [7:0] R,          
    input [7:0] G,          
    input [7:0] B,          
    output reg [7:0] grayout     
);

    reg [14:0] Lumred;      
    reg [15:0] Lumgreen;   
    reg [12:0] Lumblue;     
    wire [15:0] Lumsum;     
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            Lumred   <= 0;
            Lumgreen <= 0;
            Lumblue  <= 0;
        end
        else begin
            Lumred   <= R * 77;
            Lumgreen <= G * 151;
            Lumblue  <= B * 28;
        end
    end
    
    assign Lumsum = Lumred + Lumgreen + Lumblue;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            grayout <= 0;
        end
        else begin
            grayout <= Lumsum[15:8];
        end
    end

endmodule