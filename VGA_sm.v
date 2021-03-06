module VGA_sm(clk_25M,reset,Hs,Vs,hortional_counter,vertiacl_counter);
input clk_25M,reset;
output Hs,Vs;
output [9:0]hortional_counter;
output [9:0] vertiacl_counter;
reg Hs,Vs;

wire [9:0]hortional_counter;
wire [9:0] vertiacl_counter;
integer i,j;
/////////////////////////////////////////////
////////////////////////////////////////////
always @(posedge clk_25M or posedge reset)
begin

   if(reset)begin j<=0;i<=0;end
  
   else if(j==799)
        begin
            j<=0;
            if(i==520)i<=0;
            else i<=i+1;
          end
   else j<=j+1;
  
end
//////////////////////////////////////////// 
always @(posedge clk_25M or posedge reset)
begin

     if(reset) Hs<=1;
	else if(j == 640-1+16) Hs<=0;
	else if(j == 640-1+16+96) Hs<=1;
	else Hs<=Hs;
end
////////////////////////////////////////////// 
always @(posedge clk_25M or posedge reset)
begin

     if(reset) Vs<=1;
     else if(i==480-1+10)Vs<=0;
   
   else if(i==480-1+10+2)Vs<=1;
   
   else Vs<=Vs;
end
/////////////////////////////////////////////              
assign hortional_counter = j;
assign vertiacl_counter = i; 
               
endmodule