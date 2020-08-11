`timescale 1ns / 1ps

module deserializer_tb #(
  parameter int DESER_W = 16
);

bit clk_i  = 0;
bit srst_i = 0;

logic               ser_data_val;
logic [3:0]         ser_data_mod;
logic [15:0]        ser_data;

logic               ser_busy;

logic               int_data_val;
logic               int_data;

logic               des_data_val;
logic [DESER_W-1:0] des_data;

deserializer #(
  .DESER_W          ( DESER_W          )
) deserializer (
  .clk_i            ( clk_i            ),
  .srst_i           ( srst_i           ),

  .data_val_i       ( int_data_val     ),
  .data_i           ( int_data         ),

  .deser_data_val_o ( des_data_val     ),
  .deser_data_o     ( des_data         )
);

serializer serializer (
  .clk_i            ( clk_i            ),
  .srst_i           ( srst_i           ),

  .data_val_i       ( ser_data_val     ),
  .data_mod_i       ( ser_data_mod     ),
  .data_i           ( ser_data         ),

  .ser_data_o       ( int_data         ),
  .ser_data_val_o   ( int_data_val     ),

  .busy_o           ( ser_busy         )
);

logic msg [$];

task automatic send_msg( input logic[3:0] data_length );
  ser_data_val = 1;
  ser_data_mod = data_length;
  ser_data     = $urandom;
  if( data_length >= 3 )
    for( int i = 0; i < data_length; i++ )
      msg.push_back( ser_data[15 - i] );
  @( posedge clk_i );
  ser_data_val = 0;
  @( posedge clk_i );
  wait( !ser_busy );
endtask : send_msg

task automatic receive_msg();
  logic [DESER_W-1:0] ref_msg;
  forever
    begin
      while( des_data_val == 1'b0 )
        @( posedge clk_i );
      for( int i = 0; i < DESER_W; i++ )
        ref_msg[i] = msg.pop_front();
      if( ref_msg == des_data )
        begin
          $display( "Message correct" );
          @( posedge clk_i );
        end
      else
        begin
          $display( "Message invalid" );
          $display( "Expected msg: %b", ref_msg );
          $display( "Received msg: %b", des_data );
          @( posedge clk_i );
          $stop();
        end
    end
endtask : receive_msg

always #5 clk_i = !clk_i;

initial
  begin
    ser_data_val = 0;
    ser_data     = 0;

    @( posedge clk_i );
    srst_i = 1;
    @( posedge clk_i );
    srst_i = 0;

    fork
      receive_msg();
    join_none

    for( int i = 0; i < 16; i++ )
      send_msg( i );
    
    repeat(5)
      @( posedge clk_i );
    $display( "Test successfully passed" );
    $stop();
  end

endmodule : deserializer_tb