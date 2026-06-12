
module baudrate_gen(input clk,output rx_en,tx_en);

reg [9:0]rx_count;
reg [12:0]tx_count;

always @(posedge clk)begin 
  if(rx_count==325) rx_count<=0;
 else rx_count<=rx_count+1;
end

always @(posedge clk)begin 
  if(tx_count==5208) tx_count<=0;
 else tx_count<=tx_count+1;
end

assign rx_en=(rx_count)?0:1;
assign tx_en=(tx_count)?0:1;

endmodule
