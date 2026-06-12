module tx(input clk,rst,wr_en,en,input [7:0]data_in, output reg tx1,output busy);
 
parameter idle=2'b00;
parameter start=2'b01;
parameter data_state=2'b10;
parameter stop=2'b11;

reg [7:0]data;
reg [2:0]index;
reg[1:0]state=idle;

/*always@(posedge clk)begin 
 if(rst) begin 
  tx1=1'b1;
  state<=idle;
  index<=3'b0;
end
end
*/

always@(posedge clk)begin 
 if(rst) begin 
  tx1<=1'b1;
  state<=idle;
  index<=3'b0;
  data<=8'b0;
end
 else begin
  case(state)
   idle:begin if(wr_en) begin
                        state<=start;
                        index<=3'h0;
                        data<=data_in;
                        end
              else state<=idle;
        
        end

   start:begin if(en) begin
                      tx1<=1'b0;
                      state<=data_state;
                      end
               else state<=start;
          end

   data_state:begin if(en)begin if(index==3'h7)begin
                          tx1<=data[index];
                          state<=stop;
                          end
                          else begin
                               tx1<=data[index];
                               index<=index+1;
                               state<=data_state;
                               end
                    end

        end

   stop:begin if(en)begin state<=idle;
                    tx1<=1'b1;
                    end
              else state<=stop;

        end
  default:begin
          tx1<=1'b1;
          state<=idle;
          end

  endcase
end
end

assign busy=(state!=idle);

endmodule