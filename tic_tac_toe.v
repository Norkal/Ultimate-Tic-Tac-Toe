`timescale 1ns / 1ps

module top(
    input wire CLK,             // 100 MHz Clock
    input wire RST_BTN,         // reset button
    input wire [3:1] sw,        // switches 3,2,1
    input wire [3:1] btn,       // buttons 3,2,1
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );
    
    wire rst = ~RST_BTN;    // Reset (Active on low)

    // generate a 25 MHz pixel strobe
    reg [1:0] counter;
    reg pix_stb;
    always @(posedge CLK)
    begin
       pix_stb = &counter;
       counter = counter+1; 
    end

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023 for xmax=640
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511  for ymax=480

    wire btn3_state, btn3_dn, btn3_up;
    test_button d_btn3 (
        .clk(CLK),
        .i_btn(btn[3]),
        .o_state(btn3_state),
        .o_ondn(btn3_dn),
        .o_onup(btn3_up)
    );
    
    wire btn2_state, btn2_dn, btn2_up;
    test_button d_btn2 (
        .clk(CLK),
        .i_btn(btn[2]),
        .o_state(btn2_state),
        .o_ondn(btn2_dn),
        .o_onup(btn2_up)
    );
    
    wire btn1_state, btn1_dn, btn1_up;
    test_button d_btn1 (
        .clk(CLK),
        .i_btn(btn[1]),
        .o_state(btn1_state),
        .o_ondn(btn1_dn),
        .o_onup(btn1_up)
    );

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );
       
    reg [1:9] pos_check;   
    reg player_nr = 0;
    reg init = 0;
    reg test_row_1 = 0;
    reg test_row_2 = 0;
    reg test_row_3 = 0;
    reg test_sq_1 = 0;
    reg test_sq_2 = 0;
    reg test_sq_3 = 0;
    reg test_sq_4 = 0;
    reg test_sq_5 = 0;
    reg test_sq_6 = 0;
    reg test_sq_7 = 0;
    reg test_sq_8 = 0;
    reg test_sq_9 = 0;
    
    reg test_sq_1_p2 = 0;
    reg test_sq_2_p2 = 0;
    reg test_sq_3_p2 = 0;
    reg test_sq_4_p2 = 0;
    reg test_sq_5_p2 = 0;
    reg test_sq_6_p2 = 0;
    reg test_sq_7_p2 = 0;
    reg test_sq_8_p2 = 0;
    reg test_sq_9_p2 = 0;
    
    wire display_sq_1;
    wire display_sq_2;
    wire display_sq_3;
    wire display_sq_4;
    wire display_sq_5;
    wire display_sq_6;
    wire display_sq_7;
    wire display_sq_8;
    wire display_sq_9;
    
    wire display_sq_1_p2;
    wire display_sq_2_p2;
    wire display_sq_3_p2;
    wire display_sq_4_p2;
    wire display_sq_5_p2;
    wire display_sq_6_p2;
    wire display_sq_7_p2;
    wire display_sq_8_p2;
    wire display_sq_9_p2;
  
    parameter sq_x_offset = 10;
    parameter sq_y_offset = 10;
    
    assign display_sq_1  = ((x >  0  + sq_x_offset) & (x < 208 - sq_x_offset) & (y >  0  + sq_y_offset) & (y < 155 - sq_y_offset)) ? test_sq_1 : 0;
    assign display_sq_2  = ((x > 218 + sq_x_offset) & (x < 411 - sq_x_offset) & (y >  0  + sq_y_offset) & (y < 155 - sq_y_offset)) ? test_sq_2 : 0;
    assign display_sq_3  = ((x > 421 + sq_x_offset) & (x < 640 - sq_x_offset) & (y >  0  + sq_y_offset) & (y < 155 - sq_y_offset)) ? test_sq_3 : 0;
    assign display_sq_4  = ((x >  0  + sq_x_offset) & (x < 208 - sq_x_offset) & (y > 165 + sq_y_offset) & (y < 315 - sq_y_offset)) ? test_sq_4 : 0;
    assign display_sq_5  = ((x > 218 + sq_x_offset) & (x < 411 - sq_x_offset) & (y > 165 + sq_y_offset) & (y < 315 - sq_y_offset)) ? test_sq_5 : 0;
    assign display_sq_6  = ((x > 421 + sq_x_offset) & (x < 640 - sq_x_offset) & (y > 165 + sq_y_offset) & (y < 315 - sq_y_offset)) ? test_sq_6 : 0;
    assign display_sq_7  = ((x >  0  + sq_x_offset) & (x < 208 - sq_x_offset) & (y > 325 + sq_y_offset) & (y < 480 - sq_y_offset)) ? test_sq_7 : 0;
    assign display_sq_8  = ((x > 218 + sq_x_offset) & (x < 411 - sq_x_offset) & (y > 325 + sq_y_offset) & (y < 480 - sq_y_offset)) ? test_sq_8 : 0;
    assign display_sq_9  = ((x > 421 + sq_x_offset) & (x < 640 - sq_x_offset) & (y > 325 + sq_y_offset) & (y < 480 - sq_y_offset)) ? test_sq_9 : 0;
    
    assign display_sq_1_p2  = ((x >  0  + sq_x_offset) & (x < 208 - sq_x_offset) & (y >  0  + sq_y_offset) & (y < 155 - sq_y_offset)) ? test_sq_1_p2 : 0;
    assign display_sq_2_p2  = ((x > 218 + sq_x_offset) & (x < 411 - sq_x_offset) & (y >  0  + sq_y_offset) & (y < 155 - sq_y_offset)) ? test_sq_2_p2 : 0;
    assign display_sq_3_p2  = ((x > 421 + sq_x_offset) & (x < 640 - sq_x_offset) & (y >  0  + sq_y_offset) & (y < 155 - sq_y_offset)) ? test_sq_3_p2 : 0;
    assign display_sq_4_p2  = ((x >  0  + sq_x_offset) & (x < 208 - sq_x_offset) & (y > 165 + sq_y_offset) & (y < 315 - sq_y_offset)) ? test_sq_4_p2 : 0;
    assign display_sq_5_p2  = ((x > 218 + sq_x_offset) & (x < 411 - sq_x_offset) & (y > 165 + sq_y_offset) & (y < 315 - sq_y_offset)) ? test_sq_5_p2 : 0;
    assign display_sq_6_p2  = ((x > 421 + sq_x_offset) & (x < 640 - sq_x_offset) & (y > 165 + sq_y_offset) & (y < 315 - sq_y_offset)) ? test_sq_6_p2 : 0;
    assign display_sq_7_p2  = ((x >  0  + sq_x_offset) & (x < 208 - sq_x_offset) & (y > 325 + sq_y_offset) & (y < 480 - sq_y_offset)) ? test_sq_7_p2 : 0;
    assign display_sq_8_p2  = ((x > 218 + sq_x_offset) & (x < 411 - sq_x_offset) & (y > 325 + sq_y_offset) & (y < 480 - sq_y_offset)) ? test_sq_8_p2 : 0;
    assign display_sq_9_p2  = ((x > 421 + sq_x_offset) & (x < 640 - sq_x_offset) & (y > 325 + sq_y_offset) & (y < 480 - sq_y_offset)) ? test_sq_9_p2 : 0;
    
    wire ln_v_1;
    assign ln_v_1 = ((x > 208) & (y >  0)   & (x < 218) & (y < 480)) ? 1 : 0;
    wire ln_v_2;
    assign ln_v_2 = ((x > 411) & (y >  0)   & (x < 421) & (y < 480)) ? 1 : 0;
    wire ln_h_1;
    assign ln_h_1 = ((x > 0)   & (y >  155) & (x < 640) & (y < 165)) ? 1 : 0;
    wire ln_h_2;
    assign ln_h_2 = ((x > 0)   & (y >  315) & (x < 640) & (y < 325)) ? 1 : 0;
    
    always @ (posedge(CLK)) 
    begin
        if (sw[3] && !sw[2] && !sw[1])
        begin
            test_row_1 = 1;
        end
        else
        test_row_1 = 0;
        
        if (sw[2] && !sw[1] && !sw[3])
        begin
            test_row_2 = 1;
        end
        else
        test_row_2 = 0;
        
        if (sw[1] && !sw[2] && !sw[3])
        begin
            test_row_3 = 1;
        end
        else
        test_row_3 = 0;
        
        if (test_row_1 == 1)
        begin
            if (btn3_dn)
            begin
                if (!test_sq_1_p2 & player_nr==0)
                begin
                test_sq_1 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_1 & player_nr ==1)
                begin
                test_sq_1_p2 = 1;
                player_nr = player_nr+1; 
                end
            end
        
            if (btn2_dn)
            begin
                if (!test_sq_2_p2 & player_nr==0)
                begin
                test_sq_2 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_2 & player_nr ==1)
                begin
                test_sq_2_p2 = 1;
                player_nr = player_nr+1;
                end
            end
        
            if (btn1_dn)
            begin
                if (!test_sq_3_p2 & player_nr==0)
                begin
                test_sq_3 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_3 & player_nr ==1)
                begin
                test_sq_3_p2 = 1;
                player_nr = player_nr+1;
                end
            end
        end
        
         if (test_row_2 == 1)
        begin
            if (btn3_dn)
            begin
                if (!test_sq_4_p2 & player_nr==0)
                begin
                test_sq_4 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_4 & player_nr ==1)
                begin
                test_sq_4_p2 = 1;
                player_nr = player_nr+1;
                end
            end
        
            if (btn2_dn)
            begin
                if (!test_sq_5_p2 & player_nr==0)
                begin
                test_sq_5 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_5 & player_nr ==1)
                begin
                test_sq_5_p2 = 1;
                player_nr = player_nr+1;
                end
            end
        
            if (btn1_dn)
            begin
                if (!test_sq_6_p2 & player_nr==0)
                begin
                test_sq_6 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_6 & player_nr ==1)
                begin
                test_sq_6_p2 = 1;
                player_nr = player_nr+1;
                end
            end
        end
        
        if (test_row_3 == 1)
        begin
            if (btn3_dn)
            begin
                if (!test_sq_7_p2 & player_nr==0)
                begin
                test_sq_7 = 1;
                player_nr = player_nr+1;
                end
                else
                if (!test_sq_7 & player_nr ==1)
                begin
                test_sq_7_p2 = 1; 
                player_nr = player_nr+1;
                end
            end
        
            if (btn2_dn)
            begin
                if (!test_sq_8_p2 & player_nr==0)
                begin
                test_sq_8 = 1;
                player_nr = player_nr+1;
                end
                else             
                if (!test_sq_8 & player_nr ==1)
                begin
                test_sq_8_p2 = 1;
                player_nr = player_nr+1;
                end
            end
        
            if (btn1_dn)
            begin
                if (!test_sq_9_p2 & player_nr==0)
                begin
                test_sq_9 = 1;
                player_nr = player_nr+1;
                end
                else    
                if (!test_sq_9 & player_nr ==1)
                begin
                test_sq_9_p2 = 1;            
                player_nr = player_nr+1;
                end
            end
        end
    end
       
    assign VGA_R[3] = ln_v_1 | ln_v_2 | ln_h_1 | ln_h_2;
    assign VGA_G[3] = ln_v_1 | ln_v_2 | ln_h_1 | ln_h_2;
    assign VGA_B[3] = ln_v_1 | ln_v_2 | ln_h_1 | ln_h_2;
    assign VGA_B[2] = display_sq_1 | display_sq_2 | display_sq_3 | display_sq_4 | display_sq_5 | display_sq_6 | display_sq_7 | display_sq_8 | display_sq_9;
    assign VGA_R[2] = display_sq_1_p2 | display_sq_2_p2 | display_sq_3_p2 | display_sq_4_p2 | display_sq_5_p2 | display_sq_6_p2 | display_sq_7_p2 | display_sq_8_p2 | display_sq_9_p2;
    
endmodule