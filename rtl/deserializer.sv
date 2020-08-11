module deserializer #(
  parameter int DESER_W = 16
)(
  input                      clk_i,
  input                      srst_i,

  input                      data_val_i,
  input                      data_i,

  output logic               deser_data_val_o,
  output logic [DESER_W-1:0] deser_data_o
);

logic [$clog2(DESER_W)-1:0] cnt;

always_ff @( posedge clk_i )
  if( srst_i )
    deser_data_o <= '0;
  else if( data_val_i )
    if( DESER_W == 1 )
      deser_data_o <= data_i;
    else
      deser_data_o <= { data_i, deser_data_o[DESER_W-1:1] };

always_ff @( posedge clk_i )
  if( srst_i )
    cnt <= '0;
  else if( data_val_i )
    if( cnt == ( DESER_W-1 ) )
      cnt <= '0;
    else
      cnt <= cnt + 1;

always_ff @( posedge clk_i )
  if( srst_i )
    deser_data_val_o <= 1'b0;
  else if( data_val_i && ( cnt == ( DESER_W-1 ) ) )
    deser_data_val_o <= 1'b1;
  else
    deser_data_val_o <= 1'b0;

endmodule : deserializer