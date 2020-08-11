`timescale 1ns / 1ps

module deserializer_tb #(
  parameter int DESER_W = 16
);

bit clk_i  = 0;
bit srst_i = 0;

logic               data_val_i;
logic               data_i;

logic               deser_data_val_o;
logic [DESER_W-1:0] deser_data_o;

deserializer #(
  .DESER_W          ( DESER_W          )
) DUT (
  .clk_i            ( clk_i            ),
  .srst_i           ( srst_i           ),

  .data_val_i       ( data_val_i       ),
  .data_i           ( data_i           ),

  .deser_data_val_o ( deser_data_val_o ),
  .deser_data_o     ( deser_data_o     )
);

logic msg [$];

task automatic send_msg();
  int msg_size = $urandom_range( 3 * DESER_W );
  while( msg_size !== 0 )
    begin
      @( posedge clk_i );
      data_val_i = 1'b1;
      data_i     = $urandom_range( 1 );
      msg.push_back( data_i );
      msg_size  -= 1;
    end
  @( posedge clk_i );
  data_val_i = 1'b0;
endtask : send_msg

task automatic receive_msg();
  logic [DESER_W-1:0] ref_msg;
  forever
    begin
      while( deser_data_val_o == 1'b0 )
        @( posedge clk_i );
      for( int i = 0; i < DESER_W; i++ )
        ref_msg[i] = msg.pop_front();
      if( ref_msg == deser_data_o )
        begin
          $display( "Message correct" );
          @( posedge clk_i );
        end
      else
        begin
          $display( "Message invalid" );
          $display( "Expected msg: %b", ref_msg );
          $display( "Received msg: %b", deser_data_o );
          @( posedge clk_i );
          $stop();
        end
    end
endtask : receive_msg

always #5 clk_i = !clk_i;

initial
  begin
    data_val_i = 0;
    data_i     = 0;

    @( posedge clk_i );
    srst_i = 1;
    @( posedge clk_i );
    srst_i = 0;

    fork
      receive_msg();
    join_none

    repeat(50)
      send_msg();
    
    repeat(5)
      @( posedge clk_i );
    $display( "Test successfully passed" );
    $stop();
  end

endmodule : deserializer_tb