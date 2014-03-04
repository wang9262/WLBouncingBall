module VGA_display(clk,reset,mode,game_button_l,game_button_r,
                   RED,GRN,BLU,
       hortional_counter,vertiacl_counter);
input clk,reset,game_button_l,game_button_r;
input mode;
input [9:0]hortional_counter;
input [9:0] vertiacl_counter;
output [2:0]RED,GRN;
output [1:0]BLU;
wire [2:0]RED,GRN;
wire [1:0]BLU;

// integer cnt1; 
   reg [7:0]RGB;
reg [7:0]RGB0;
reg [7:0]RGB1;
reg [7:0]RGB2;
reg [7:0]RGB3;
reg [7:0]RGB4;
assign {RED,BLU,GRN} = RGB;
////////////////////////////
reg a;
always @(posedge clk)
begin
   if(mode==1) a<=1;
   else a<=0;
end

reg [2:0]n;
always @( posedge a)
   begin
     if(reset) n<=0;
   else if(n==5)   n<=0;
   else n<=n+1;
   end

//////////////////////////// 
always @(reset,n,RGB0,RGB1,RGB2,RGB3,RGB4)
begin
    if(reset) begin RGB = 0;end
else begin
    case(n)
        0:begin RGB=RGB0; end
    1:begin RGB=RGB1; end
    2:begin RGB=RGB0^RGB1;end
    3:begin RGB=RGB2; end
    4:begin RGB=RGB3; end
    5:begin RGB=RGB4; end
   endcase
end
end     
////////////////// hortional bar ////////////////////////////////////
always @(hortional_counter, vertiacl_counter)
     begin
    if(0<=hortional_counter && hortional_counter <= 639 
           && 0<=vertiacl_counter && vertiacl_counter <= 120 )
    RGB0 = 8'b00011100;
   
      else if(0<=hortional_counter && hortional_counter <= 639 
              && 121<=vertiacl_counter && vertiacl_counter <= 240 )
    RGB0 = 8'b11100000;
    
    else if(0<=hortional_counter && hortional_counter <= 639 
      && 241<=vertiacl_counter && vertiacl_counter <= 360 )
    RGB0 = 8'b11111000;
    
    else if(0<=hortional_counter && hortional_counter <= 639 
      && 361<=vertiacl_counter && vertiacl_counter <= 480)
    RGB0 = 8'b11111111;
       
    else RGB0 = 8'b00000000;
   
/////////////////// vertiacl bar /////////////////////////////
    if(0<=hortional_counter && hortional_counter <= 79 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b11110000;
     
    else if(80<=hortional_counter && hortional_counter <= 159 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b00011100;
      
    else if(160<=hortional_counter && hortional_counter <= 239 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b00110011;
       
    else if(240<=hortional_counter && hortional_counter <= 319 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
      RGB1 = 8'b11011011;

    else if(320<=hortional_counter && hortional_counter <=399 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b01010101;
         
    else if(400<=hortional_counter && hortional_counter <= 479 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b11001100;
          
    else if (480<=hortional_counter && hortional_counter <= 559 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b00110011;
           
    else if (560<=hortional_counter && hortional_counter <= 640 &&
      0<=vertiacl_counter && vertiacl_counter <= 480)
     RGB1 = 8'b00111100;
         else RGB1 = 8'b00000000;
   
     
   end
////////////////////////////cubic//////////////////////////////
reg [9:0]x,y;
reg x_dir,y_dir;
always @(posedge clk or posedge reset)
begin
	if(reset)
		x_dir <=1; 
	else if (x==0)
		x_dir <=1;
	else if (x==589)
		x_dir <= 0;
	else
		x_dir <= x_dir;
end
   
always @(posedge clk or posedge reset)
begin
	if(reset)
		y_dir <=1; 
	else if (y==0)
		y_dir <=1;
	else if (y==429)
		y_dir <= 0;
	else
		y_dir<= y_dir;
end
   
   
always @(posedge clk or posedge reset)
begin
	if (reset)
		x<=50;
	else if(x_dir)
		x <=x+1;
	else
		x<=x-1;
end
   
always @(posedge clk or posedge reset )
begin
	if (reset)
		y <= 50; 
    else if(y_dir )
		y <= y+1;
	else
		y <= y-1;
end
   
always @(x,y,hortional_counter,vertiacl_counter)
begin
	if(x <= hortional_counter && hortional_counter <= x+100
     && y <= vertiacl_counter && vertiacl_counter <= y+100)
		RGB2=8'b11100000;
	else
		RGB2=8'b00000000;
end
////////////////////// ball /////////////////////////////
reg [9:0]x1,y1;
reg x_dir1,y_dir1;
always @(posedge clk or posedge reset)
begin
if(reset)x_dir1 <=1; 
   else if (x1==50)
    x_dir1 <=1;
else if (x1==589)
   x_dir1 <= 0;
   else
   x_dir1 <= x_dir1;
   end
   
always @(posedge clk or posedge reset)
begin
if(reset)y_dir1 <=1; 
   else if (y1==50)
    y_dir1 <=1;
else if (y1==429)
   y_dir1 <= 0;
   else
   y_dir1<= y_dir1;
   end
   
   
always @(posedge clk or posedge reset)
begin
if (reset)x1<=50;
else if(x_dir1 )
   x1 <=x1+1;
   else 
   x1<=x1-1;end
   
always @(posedge clk or posedge reset )
   begin
if (reset)y1<=50; 
    else if(y_dir1 )
   y1 <=y1+1;
   else
   y1<=y1-1;end
    
reg [31:0] A;
always @( * )
begin
   A=((hortional_counter-x1)*(hortional_counter-x1)+(vertiacl_counter-y1)*(vertiacl_counter-y1));
    if(A<=2500) RGB3=8'b11100011;
    else RGB3=8'b00000000;
end 
////////////////// board control////////////////////////////
reg [9:0] x_board;//board_width=110
parameter y_board1=479,y_board2=459;
always @(posedge clk or posedge reset) 
begin
	if(reset) 
		begin
			x_board <= 320;
		end
	else 
	begin
		if(game_button_l)
			begin
				if(x_board < 679-110) 
					x_board <= x_board+1;
				else 
					x_board <= x_board;
			end

		if(game_button_r)
		begin
			if(x_board>110)
				x_board <= x_board-1;
			else 
				x_board <= x_board;
		end

	end
end

////////////////////// ball and board display ////////////////////////
reg [9:0]x2,y2;
reg x_dir2,y_dir2;
reg   [32:0]block1_x=100;
reg   [32:0]block1_y=70;
reg   [32:0]block2_x=440;
reg   [32:0]block2_y=70;
reg   [32:0]block3_x=100;
reg   [32:0]block3_y=170;
reg   [32:0]block4_x=440;
reg   [32:0]block4_y=170;
    
always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			y_dir2 <=1;
			x_dir2 <=1;
			block1_x<=100;
			block1_y<=70;
			block2_x<=440;
			block2_y<=70;
			block3_x<=100;
			block3_y<=170;
			block4_x<=440;
			block4_y<=170;
		end

	else if (y2==10)
		y_dir2 <=1;
	else if (y2==469) 
		y_dir2 <= 0;

	else if (x2==10)
		x_dir2 <=1;
	else if (x2==629)
		x_dir2 <= 0;

	else if(y2>479-20-10) 
		begin 
			if(x_board-110<x2 && x2<x_board+110)
				begin
					y_dir2 <= 0;
					x_dir2 <= x_dir2;
				end
			else if(x_board-110-10<=x2 && x2<=x_board-110)
				begin
					y_dir2 <=0;
					x_dir2 <=0;
				end
     
			else if(x_board+110<=x2 && x2<=x_board+110+10)
			begin
				y_dir2 <=0;
				x_dir2 <=1;
			end
		end

///////////////////////////////////////////////////////
/******************block1 up**************************/    
	else if(y2==block1_y-10 && block1_x<x2 && x2<block1_x+100) 
		begin 
			y_dir2 <= 0; 
			x_dir2 <= x_dir2;
			block1_x<=9999999;
			block1_y<=9999999;
		end
    
/******************block1 bottom**************************/
	else if(y2==block1_y+30+10 && block1_x<x2 && x2<block1_x+100) 
		begin 
			y_dir2 <= 1; 
			x_dir2 <= x_dir2;
			block1_x<=9999999;
			block1_y<=9999999;
		end
/******************block1 left**************************/
	else if(x2==block1_x+10 && block1_y<y2 && y2<block1_y+30) 
		begin 
			y_dir2 <= y_dir2; 
			x_dir2 <= 0;
			block1_x<=9999999;
			block1_y<=9999999;
		end
    
/******************block1 right**************************/
	else if(x2==block1_x+100+10 && block1_y<y2 && y2<block1_y+30) 
		begin 
			y_dir2 <= y_dir2; 
			x_dir2 <= 1;
			block1_x<=9999999;
			block1_y<=9999999;
		end

   ///////////////////////////////////////////////////////
/******************block2 up**************************/    
else if(y2==block2_y-10 && block2_x<x2 && x2<block2_x+100) 
    begin 
		y_dir2 <= 0; 
		x_dir2 <= x_dir2;
		block2_x<=9999999;
		block2_y<=9999999;
	end
    
/******************block2 bottom**************************/
else if(y2==block2_y+30+10 && block2_x<x2 && x2<block2_x+100) 
    begin 
		y_dir2 <= 1; 
		x_dir2 <= x_dir2;
		block2_x<=9999999;
		block2_y<=9999999;
	end
/******************block2 left**************************/
else if(x2==block2_x+10 && block2_y<y2 && y2<block2_y+30) 
    begin 
		y_dir2 <= y_dir2; 
		x_dir2 <= 0;
		block2_x<=9999999;
		block2_y<=9999999;
	end
    
/******************block2 right**************************/
else if(x2==block2_x+100+10 && block2_y<y2 && y2<block2_y+30) 
    begin 
		y_dir2 <= y_dir2; 
		x_dir2 <= 1;
		block2_x<=9999999;
		block2_y<=9999999;
	end

   ///////////////////////////////////////////////////////
/******************block3 up**************************/    
else if(y2==block3_y-10 && block3_x<x2 && x2<block3_x+100) 
    begin 
		y_dir2 <= 0; 
		x_dir2 <= x_dir2;
		block3_x<=9999999;
		block3_y<=9999999;
	end
    
/******************block3 bottom**************************/
else if(y2==block3_y+30+10 && block3_x<x2 && x2<block3_x+100) 
    begin 
		y_dir2 <= 1; 
		x_dir2 <= x_dir2;
		block3_x<=9999999;
		block3_y<=9999999;
	end
/******************block3 left**************************/
else if(x2==block3_x+10 && block3_y<y2 && y2<block3_y+30) 
    begin 
		y_dir2 <= y_dir2; 
		x_dir2 <= 0;
		block3_x<=9999999;
		block3_y<=9999999;
	end
    
/******************block3 right**************************/
else if(x2==block3_x+100+10 && block3_y<y2 && y2<block3_y+30) 
    begin 
		y_dir2 <= y_dir2; 
		x_dir2 <= 1;
		block3_x<=9999999;
		block3_y<=9999999;
	end

   ///////////////////////////////////////////////////////
/******************block4 up**************************/    
else if(y2==block4_y-10 && block4_x<x2 && x2<block4_x+100) 
    begin 
		y_dir2 <= 0; 
		x_dir2 <= x_dir2;
		block4_x<=9999999;
		block4_y<=9999999;
	end
    
/******************block4 bottom**************************/
else if(y2==block4_y+30+10 && block4_x<x2 && x2<block4_x+100) 
    begin 
		y_dir2 <= 1; 
		x_dir2 <= x_dir2;
		block4_x<=9999999;
		block4_y<=9999999;
	end
/******************block4 left**************************/
else if(x2==block4_x+10 && block4_y<y2 && y2<block4_y+30) 
    begin 
		y_dir2 <= y_dir2; 
		x_dir2 <= 0;
		block4_x<=9999999;
		block4_y<=9999999;
	end
    
/******************block4 right**************************/
else if(x2==block4_x+100+10 && block4_y<y2 && y2<block4_y+30) 
    begin 
		y_dir2 <= y_dir2; 
		x_dir2 <= 1;
		block4_x<=9999999;
		block4_y<=9999999;
	end


  
            
////////////**************///////////////////////// 

else 
	begin 
		y_dir2<= y_dir2; 
		x_dir2 <= x_dir2;
	end
end
   
//////////////////// movement ///////////////////////////////

always @(posedge clk or posedge reset)
begin
	if(reset)
		x2<=600;
	else if(x_dir2 )
		x2 <=x2+1;
	else 
		x2<=x2-1;
end
   
always @(posedge clk or posedge reset )
begin
	if(reset)
		y2<=450; 
    else if(y_dir2 )
		y2 <=y2+1;
	else
		y2<=y2-1;
end
///////////////////// show ////////////////////////
   
reg [31:0] B;
always @( * )
begin
   B=((hortional_counter-x2)*(hortional_counter-x2)+(vertiacl_counter-y2)*(vertiacl_counter-y2));
    if(B<=100) RGB4=8'b00000011;//ball

else if (x_board-110<=hortional_counter && hortional_counter <= x_board+110 &&
           y_board2<=vertiacl_counter && vertiacl_counter <= y_board1)
     RGB4=8'b10110101;//board
    
    else if (block1_x<=hortional_counter && hortional_counter <= block1_x+100 &&
           block1_y<=vertiacl_counter && vertiacl_counter <=block1_y+30 )
     RGB4=8'b11100000;//block1
    
    else if (block2_x<=hortional_counter && hortional_counter <= block2_x+100 &&
          block2_y<=vertiacl_counter && vertiacl_counter <=block2_y+30 )
     RGB4=8'b00011100;//block2
    
    else if (block3_x<=hortional_counter && hortional_counter <=block3_x+100 &&
           block3_y<=vertiacl_counter && vertiacl_counter <=block3_y+30)
     RGB4=8'b00000011;//block3
      
    else if (block4_x<=hortional_counter && hortional_counter <= block4_x+100 &&
           block4_y<=vertiacl_counter && vertiacl_counter <=block4_y+30)
     RGB4=8'b10010010;//block4
    
	else RGB4=8'b00000000;//others-black
end        
endmodule