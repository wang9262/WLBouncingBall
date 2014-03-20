`timescale 1 ps / 1 ps

module VGA_display(clk1,
				   clk,
				   reset,
				   level,
				   ps2_byte,
				   ps2_state,
                   RED,GRN,BLU,
				   hortional_counter,
				   vertiacl_counter,speaker,bouncetest,scoretest);
input clk,clk1,reset;
output speaker,bouncetest,scoretest;
input [7:0]ps2_byte;
input ps2_state;
reg ps2state;
input [9:0]hortional_counter;
input [9:0] vertiacl_counter;
output RED,GRN,BLU;
wire [2:0]RGBx;
wire RED,GRN,BLU;
reg [6:0]m;
reg gameoverflag=0;
reg guoguanflag=0;
reg [2:0]RGB_top;
reg [2:0]RGB;
reg [2:0]RGB0;
reg [2:0]RGB1;
reg [2:0]RGB2;
reg [7:0]tmpbytes;

reg speaker;
reg bouncespeaker;
reg scorespeaker;
assign bouncetest = bouncespeaker;
assign scoretest = scorespeaker;
assign {BLU,GRN,RED} = RGB_top;

always @(hortional_counter, vertiacl_counter)
begin
 if(n==1)
 begin
	if(gameoverflag)
		begin
			if((540<hortional_counter && hortional_counter <640)||
			(240<hortional_counter && hortional_counter <399&&240<vertiacl_counter&& vertiacl_counter<359))
				RGB_top = RGBx;
			else 
			 begin
			
				RGB_top = RGB;
			      
			end	
		end
	else
	 
		begin
			if(540<hortional_counter && hortional_counter <640)
				RGB_top = RGBx;
			else
			 begin
				RGB_top = RGB;
			/*else if(n==2)
				RGB_top = RGB0;
			else if(n==3)
			    RGB_top = RGB1;
			else if(n==4)
			    RGB_top = RGB2;  */  	
			 end	
		end
	end
else if(n==2)
 begin
   /*  if(540<hortional_counter && hortional_counter <640)
				RGB_top = RGBx;
			else    */
			
				RGB_top = RGB0;
 end
 
 else if(n==3)
 begin
   /*  if(540<hortional_counter && hortional_counter <640)
				RGB_top = RGBx;
			else   */
			
				RGB_top = RGB1;
 end	
 
 else if(n==4)
 begin
   /*  if(540<hortional_counter && hortional_counter <640)
				RGB_top = RGBx;
			else   */
			
				RGB_top = RGB2;
 end	 	
  		 	
end

/*******************custom blocks,board  and ball**************************/

parameter x_left = 1,x_right = 540;
parameter y_up   = 0,y_down = 479;


//custom board
parameter board_centerx = 250,half_board_width = 55,board_width = 110;
parameter board_centery = 470,half_board_height = 10,board_height = 20;
parameter board_speedx = 2,board_speedy = 1;
reg [9:0]board_cx,board_cy;

always @(posedge clk or posedge reset)
begin
	if(reset)
		begin 
			board_cx <= board_centerx;
			board_cy <= board_centery; 
		end
	else
		begin
			if(ps2_state==1)
			begin
			//	tmpbytes = ps2_byte;
			//else if(ps2_state==0)
			//	tmpbytes = 8'b0;
			if(ps2_byte == "A")
				begin
					if(board_cx <= (half_board_width + x_left)) 
						board_cx <= board_cx;
					else 
						board_cx <= board_cx - board_speedx;
				end
			else if(ps2_byte == "D")
				begin
					if(board_cx >= (x_right - half_board_width))
						board_cx <= board_cx;
					else 
						board_cx <= board_cx + board_speedx;	
				end
			else if(ps2_byte == "W")
				begin
					if(board_cy <= 400 )
						board_cy <= board_cy;
					else 
						board_cy <= board_cy - board_speedy;	
				end
			else if(ps2_byte == "S")
				begin
					if(board_cy >= 470)
						board_cy <= board_cy;
					else 
						board_cy <= board_cy + board_speedy;	
				end
				
			else
			 begin
				board_cx <= board_cx;
				board_cy <= board_cy;
			 end	
			 end
			 else 
				begin
				board_cx <= board_cx;
				board_cy <= board_cy;
				end
				
		end
end

  
/********************all blocks************************************
	1--2--3--4--5--6--7
	|				  |
	8-----------------9
	|				  |
	10----------------11
	|				  |
	12-13-14-15-16-17-18
******************************************************************/

parameter blk1_l = 60,   	blk1_r = 118 , 			blk1_u = 30 		,blk1_d = 	 58;
parameter blk2_l = 2*60, 	blk2_r = 118 +60 , 		blk2_u = 30 		,blk2_d = 	 58;
parameter blk3_l = 3*60, 	blk3_r = 118 +60*2, 	blk3_u = 30 		,blk3_d =	 58;
parameter blk4_l = 4*60,	blk4_r = 118 +60*3, 	blk4_u = 30 		,blk4_d = 	 58;
parameter blk5_l = 5*60, 	blk5_r = 118 +60*4, 	blk5_u = 30 		,blk5_d = 	 58;
parameter blk6_l = 6*60, 	blk6_r = 118 +60*5, 	blk6_u = 30 		,blk6_d = 	 58;
parameter blk7_l = 7*60, 	blk7_r = 118 +60*6, 	blk7_u = 30 		,blk7_d = 	 58;
parameter blk8_l = 60,   	blk8_r = 118 , 			blk8_u = 2*30 		,blk8_d =   58+30;
parameter blk9_l = 7*60, 	blk9_r = 118 +60*6, 	blk9_u = 2*30 		,blk9_d =   58+30;
parameter blk10_l = 60,  	blk10_r = 118 , 		blk10_u = 3*30 		,blk10_d = 58+2*30;
parameter blk11_l = 7*60,	blk11_r = 118 +60*6, 	blk11_u = 3*30 		,blk11_d = 58+2*30;
parameter blk12_l = 60,  	blk12_r = 118 , 		blk12_u = 4*30 		,blk12_d = 58+3*30;
parameter blk13_l = 2*60,	blk13_r = 118 +60, 		blk13_u = 4*30 		,blk13_d = 58+3*30;
parameter blk14_l = 3*60,	blk14_r = 118 +60*2, 	blk14_u = 4*30 		,blk14_d = 58+3*30;
parameter blk15_l = 4*60,	blk15_r = 118 +60*3, 	blk15_u = 4*30 		,blk15_d = 58+3*30;
parameter blk16_l = 5*60,	blk16_r = 118 +60*4, 	blk16_u = 4*30 		,blk16_d = 58+3*30;
parameter blk17_l = 6*60,	blk17_r = 118 +60*5, 	blk17_u = 4*30 		,blk17_d = 58+3*30;
parameter blk18_l = 7*60,	blk18_r = 118 +60*6, 	blk18_u = 4*30 		,blk18_d = 58+3*30;



reg[8:0]block1_l,block1_r,block1_u,block1_d;
reg[8:0]block2_l,block2_r,block2_u,block2_d;
reg[8:0]block3_l,block3_r,block3_u,block3_d;
reg[8:0]block4_l,block4_r,block4_u,block4_d;
reg[8:0]block5_l,block5_r,block5_u,block5_d;
reg[8:0]block6_l,block6_r,block6_u,block6_d;
reg[8:0]block7_l,block7_r,block7_u,block7_d;
reg[8:0]block8_l,block8_r,block8_u,block8_d;
reg[8:0]block9_l,block9_r,block9_u,block9_d;
reg[8:0]block10_l,block10_r,block10_u,block10_d;
reg[8:0]block11_l,block11_r,block11_u,block11_d;
reg[8:0]block12_l,block12_r,block12_u,block12_d;
reg[8:0]block13_l,block13_r,block13_u,block13_d;
reg[8:0]block14_l,block14_r,block14_u,block14_d;
reg[8:0]block15_l,block15_r,block15_u,block15_d;
reg[8:0]block16_l,block16_r,block16_u,block16_d;
reg[8:0]block17_l,block17_r,block17_u,block17_d;
reg[8:0]block18_l,block18_r,block18_u,block18_d;

//ball parameter
reg [9:0]ball_centerx,ball_centery;
reg ball_xdir,ball_ydir;
parameter ball_r = 10;
parameter speed = 1,flag_up = 0,flag_down = 1,flag_left = 0,flag_right = 1;
reg [17:0] blk_state = 18'b111111111111111111;

/**************Main Logic****************/
always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			m<=0;
			bouncespeaker<=0;
			scorespeaker<=0;
			gameoverflag<=0;
			guoguanflag<=0;
			blk_state <= 18'b111111111111111111;
			ball_xdir <= flag_right;
			ball_ydir <= flag_down;
			block1_l <= blk1_l;block1_r <= blk1_r;block1_u <= blk1_u;block1_d <= blk1_d;
			block2_l <= blk2_l;block2_r <= blk2_r;block2_u <= blk2_u;block2_d <= blk2_d;
			block3_l <= blk3_l;block3_r <= blk3_r;block3_u <= blk3_u;block3_d <= blk3_d;
			block4_l <= blk4_l;block4_r <= blk4_r;block4_u <= blk4_u;block4_d <= blk4_d;
			block5_l <= blk5_l;block5_r <= blk5_r;block5_u <= blk5_u;block5_d <= blk5_d;
			block6_l <= blk6_l;block6_r <= blk6_r;block6_u <= blk6_u;block6_d <= blk6_d;
			block7_l <= blk7_l;block7_r <= blk7_r;block7_u <= blk7_u;block7_d <= blk7_d;
			block8_l <= blk8_l;block8_r <= blk8_r;block8_u <= blk8_u;block8_d <= blk8_d;
			block9_l <= blk9_l;block9_r <= blk9_r;block9_u <= blk9_u;block9_d <= blk9_d;
			block10_l <= blk10_l;block10_r <= blk10_r;block10_u <= blk10_u;block10_d <= blk10_d;
			block11_l <= blk11_l;block11_r <= blk11_r;block11_u <= blk11_u;block11_d <= blk11_d;
			block12_l <= blk12_l;block12_r <= blk12_r;block12_u <= blk12_u;block12_d <= blk12_d;
			block13_l <= blk13_l;block13_r <= blk13_r;block13_u <= blk13_u;block13_d <= blk13_d;
			block14_l <= blk14_l;block14_r <= blk14_r;block14_u <= blk14_u;block14_d <= blk14_d;
			block15_l <= blk15_l;block15_r <= blk15_r;block15_u <= blk15_u;block15_d <= blk15_d;
			block16_l <= blk16_l;block16_r <= blk16_r;block16_u <= blk16_u;block16_d <= blk16_d;
			block17_l <= blk17_l;block17_r <= blk17_r;block17_u <= blk17_u;block17_d <= blk17_d;
			block18_l <= blk18_l;block18_r <= blk18_r;block18_u <= blk18_u;block18_d <= blk18_d;
		end
	else if((ball_centerx - ball_r) == x_left)
	begin
		ball_xdir <= flag_right;
		bouncespeaker<=1;
	end	
	else if((ball_centerx + ball_r) == x_right)
	begin
		ball_xdir <= flag_left;
		bouncespeaker<=1;
	end	
	else if((ball_centery - ball_r) == y_up)
	begin
		ball_ydir <= flag_down;
		bouncespeaker<=1;
	end	
	else if(ball_centery  == board_cy)
		//ball_ydir <= flag_up;
		begin
			gameoverflag<=1;                             //gameover
		end
	else if(m==18)                                       //guoguan
	begin
		guoguanflag<=1;
		gameoverflag<=1;
	end
	else if(ball_centery == (board_cy - ball_r - half_board_height))
		begin
			if(ball_centerx <= (board_cx + 55) && ball_centerx >= (board_cx - 55))
				begin
					ball_ydir <= flag_up;
					ball_xdir <= ball_xdir;
					bouncespeaker<=1;
				end
		end
	//bounce the bottom
	else if((ball_centery - ball_r) == blk18_d && (blk_state[11]||blk_state[12]||blk_state[13]||blk_state[14]||
													blk_state[15]||blk_state[16]||blk_state[17]))		//12~~18
			begin 
				ball_xdir <= ball_xdir;
				if(blk12_l < ball_centerx && blk12_r > ball_centerx && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] <= 0;
						ball_ydir <= flag_down;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk13_l < ball_centerx && blk13_r > ball_centerx && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] <= 0;
						ball_ydir <= flag_down;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk14_l < ball_centerx && blk14_r > ball_centerx && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] <= 0;
						ball_ydir <= flag_down;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk15_l < ball_centerx && blk15_r > ball_centerx && blk_state[14])
					begin
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
						blk_state[14] <= 0;
						ball_ydir <= flag_down;
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
					end	
				else if(blk16_l < ball_centerx && blk16_r > ball_centerx && blk_state[15])
					begin
						blk_state[15] <= 0;
						ball_ydir <= flag_down;
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end	
				else if(blk17_l < ball_centerx && blk17_r > ball_centerx && blk_state[16])
					begin
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
						blk_state[16] <= 0;
						ball_ydir <= flag_down;
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
					end	
				else if(blk18_l < ball_centerx && blk18_r > ball_centerx && blk_state[17])
					begin
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
						blk_state[17] <= 0;
						ball_ydir <= flag_down;
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
					end
			end
	else if((ball_centery - ball_r) == blk10_d && (blk_state[9]||blk_state[10]))       //10--11
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk10_l < ball_centerx && blk10_r > ball_centerx && blk_state[9])
					begin
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
						blk_state[9] <= 0;
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
						ball_ydir <= flag_down;
					end
				else if(blk11_l < ball_centerx && blk11_r > ball_centerx && blk_state[10])
					begin
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
						blk_state[10] <= 0;
						ball_ydir <= flag_down;
						block11_l <= 9999;block11_r <= 9999;block11_u <= 9999;block11_d <= 9999;
					end
			end
	else if((ball_centery - ball_r) == blk8_d &&(blk_state[7]||blk_state[8]))  //8--9
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk8_l < ball_centerx && blk8_r > ball_centerx && blk_state[7])
					begin
						blk_state[7] <= 0;
						ball_ydir <= flag_down;
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end	
				else if(blk9_l < ball_centerx && blk9_r > ball_centerx && blk_state[8])
					begin
						blk_state[8] <= 0;
						ball_ydir <= flag_down;
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
			end
	else if((ball_centery - ball_r) == blk1_d&&(blk_state[0]||blk_state[1]||blk_state[2]||blk_state[3]||blk_state[4]||blk_state[5]||blk_state[6])) //1--7
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk1_l < ball_centerx && blk1_r > ball_centerx && blk_state[0])
					begin
						blk_state[0] <= 0;
						ball_ydir <= flag_down;
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk3_l < ball_centerx && blk3_r > ball_centerx && blk_state[2])
					begin
						blk_state[2] <= 0;
						ball_ydir <= flag_down;
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk4_l < ball_centerx && blk4_r > ball_centerx && blk_state[3])
					begin
						blk_state[3] <= 0;
						ball_ydir <= flag_down;
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk5_l < ball_centerx && blk5_r > ball_centerx && blk_state[4])
					begin
						blk_state[4] <= 0;
						ball_ydir <= flag_down;
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk6_l < ball_centerx && blk6_r > ball_centerx && blk_state[5])
					begin
						blk_state[5] <= 0;
						ball_ydir <= flag_down;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
					end
				else if(blk7_l < ball_centerx && blk7_r > ball_centerx && blk_state[6])
					begin
						blk_state[6] <= 0;
						ball_ydir <= flag_down;
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk2_l < ball_centerx && blk2_r > ball_centerx && blk_state[1])
					begin
						ball_ydir <= flag_down;
						blk_state[1] <= 0;
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
			end
	//bounce the upside
	else if((ball_centery + ball_r) == blk18_u && (blk_state[11]||blk_state[12]||blk_state[13]||blk_state[14]||
													blk_state[15]||blk_state[16]||blk_state[17]))    //12--18
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk12_l < ball_centerx && blk12_r > ball_centerx && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] <= 0;
						ball_ydir <= flag_up;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk13_l < ball_centerx && blk13_r > ball_centerx && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] <= 0;
						ball_ydir <= flag_up;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk14_l < ball_centerx && blk14_r > ball_centerx && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] <= 0;
						ball_ydir <= flag_up;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk15_l < ball_centerx && blk15_r > ball_centerx && blk_state[14])
					begin
						blk_state[14] <= 0;
						ball_ydir <= flag_up;
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end	
				else if(blk16_l < ball_centerx && blk16_r > ball_centerx && blk_state[15])
					begin
						blk_state[15] <= 0;
						ball_ydir <= flag_up;
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end	
				else if(blk17_l < ball_centerx && blk17_r > ball_centerx && blk_state[16])
					begin
						blk_state[16] <= 0;
						ball_ydir <= flag_up;
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end	
				else if(blk18_l < ball_centerx && blk18_r > ball_centerx && blk_state[17])
					begin
						blk_state[17] <= 0;
						ball_ydir <= flag_up;
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
			end
	else if((ball_centery + ball_r) == blk10_u&& (blk_state[9]||blk_state[10]))				//10--11
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk10_l < ball_centerx && blk10_r > ball_centerx && blk_state[9])
					begin
						blk_state[9] <= 0;
						ball_ydir <= flag_up;
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk11_l < ball_centerx && blk11_r > ball_centerx && blk_state[10])
					begin
						blk_state[10] <= 0;
						ball_ydir <= flag_up;
						block11_l <= 9999;block11_r <= 9999;block11_u <= 9999;block11_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
			end
	else if((ball_centery + ball_r) == blk8_u &&(blk_state[7]||blk_state[8]) )				//8--9
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk8_l < ball_centerx && blk8_r > ball_centerx && blk_state[7])
					begin
						blk_state[7] <= 0;
						ball_ydir <= flag_up;
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end	
				else if(blk9_l < ball_centerx && blk9_r > ball_centerx && blk_state[8])
					begin
						ball_ydir <= flag_up;
						blk_state[8] <= 0;
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
			end
	else if((ball_centery + ball_r) == blk1_u&&(blk_state[0]||blk_state[1]||blk_state[2]||blk_state[3]||blk_state[4]||blk_state[5]||blk_state[6]))		//1--7
			begin 
				
				ball_xdir <= ball_xdir;
				if(blk1_l < ball_centerx && blk1_r > ball_centerx && blk_state[0])
					begin
						blk_state[0] <= 0;
						ball_ydir <= flag_up;
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk3_l < ball_centerx && blk3_r > ball_centerx && blk_state[2])
					begin
						blk_state[2] <= 0;
						ball_ydir <= flag_up;
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk4_l < ball_centerx && blk4_r > ball_centerx && blk_state[3])
					begin
						blk_state[3] <= 0;
						ball_ydir <= flag_up;
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk5_l < ball_centerx && blk5_r > ball_centerx && blk_state[4])
					begin
						blk_state[4] <= 0;
						ball_ydir <= flag_up;
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk6_l < ball_centerx && blk6_r > ball_centerx && blk_state[5])
					begin
						blk_state[5] <= 0;
						ball_ydir <= flag_up;
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk7_l < ball_centerx && blk7_r > ball_centerx && blk_state[6])
					begin
						blk_state[6] <= 0;
						ball_ydir <= flag_up;
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk2_l < ball_centerx && blk2_r > ball_centerx && blk_state[1])
					begin
						blk_state[1] <= 0;
						ball_ydir <= flag_up;
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
			end
	//bounce the left 
	else if((ball_centerx + ball_r) == blk1_l && (blk_state[0]||blk_state[7]||blk_state[9]||blk_state[11]))		//1,8,10,12
		begin
			
			ball_ydir <= ball_ydir;
				if(blk12_u < ball_centery && blk12_d > ball_centery && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk10_u < ball_centery && blk10_d > ball_centery && blk_state[9])
					begin
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
						blk_state[9] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk8_u < ball_centery && blk18_d > ball_centery && blk_state[7])
					begin
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
						blk_state[7] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk1_u < ball_centery && blk1_d > ball_centery && blk_state[0])
					begin
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
						blk_state[0] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx + ball_r) == blk2_l &&(blk_state[1]||blk_state[12]))				//2,13
		begin
			
			ball_ydir <= ball_ydir;
				if(blk2_u < ball_centery && blk2_d > ball_centery && blk_state[1])
					begin
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
						blk_state[1] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk13_u < ball_centery && blk13_d > ball_centery && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx + ball_r) == blk3_l&&(blk_state[2]||blk_state[13]))				//3,14
		begin
			
			ball_ydir <= ball_ydir;
				if(blk3_u < ball_centery && blk3_d > ball_centery && blk_state[2])
					begin
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
						blk_state[1] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk14_u < ball_centery && blk14_d > ball_centery && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx + ball_r) == blk4_l&&(blk_state[3]||blk_state[14]))				//4,15
		begin
			
			ball_ydir <= ball_ydir;
				if(blk4_u < ball_centery && blk4_d > ball_centery && blk_state[3])
					begin
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
						blk_state[3] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk15_u < ball_centery && blk15_d > ball_centery && blk_state[14])
					begin
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
						blk_state[14] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx + ball_r) == blk5_l&&(blk_state[4]||blk_state[15]))				//5,16
		begin
			
			ball_ydir <= ball_ydir;
				if(blk5_u < ball_centery && blk5_d > ball_centery && blk_state[4])
					begin
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
						blk_state[3] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk16_u < ball_centery && blk16_d > ball_centery && blk_state[15])
					begin
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
						blk_state[15] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx + ball_r) == blk6_l&&(blk_state[5]||blk_state[16]))				//6,17
		begin
			
			ball_ydir <= ball_ydir;
				if(blk6_u < ball_centery && blk6_d > ball_centery && blk_state[5])
					begin
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
						blk_state[5] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk15_u < ball_centery && blk15_d > ball_centery && blk_state[16])
					begin
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
						blk_state[16] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx + ball_r) == blk18_l&&(blk_state[6]||blk_state[8]||blk_state[10]||blk_state[17]))				//7,9,11,18
		begin
			
			ball_ydir <= ball_ydir;
				if(blk11_u < ball_centery && blk11_d > ball_centery && blk_state[10])
					begin
						block11_l <= 9999;block12_r <= 9999;block11_u <= 9999;block11_d <= 9999;
						blk_state[10] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk9_u < ball_centery && blk9_d > ball_centery && blk_state[8])
					begin
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
						blk_state[8] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk18_u < ball_centery && blk18_d > ball_centery && blk_state[17])
					begin
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
						blk_state[17] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk7_u < ball_centery && blk7_d > ball_centery && blk_state[6])
					begin
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
						blk_state[6] <= 0;
						ball_xdir <= flag_left;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	//bounce the right
	else if((ball_centerx - ball_r) == blk1_r&& (blk_state[0]||blk_state[7]||blk_state[9]||blk_state[11]))		//1,8,10,12
		begin
			
			ball_ydir <= ball_ydir;
				if(blk12_u < ball_centery && blk12_d > ball_centery && blk_state[11])
					begin
						block12_l <= 9999;block12_r <= 9999;block12_u <= 9999;block12_d <= 9999;
						blk_state[11] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk10_u < ball_centery && blk10_d > ball_centery && blk_state[9])
					begin
						block10_l <= 9999;block10_r <= 9999;block10_u <= 9999;block10_d <= 9999;
						blk_state[9] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk8_u < ball_centery && blk18_d > ball_centery && blk_state[7])
					begin
						block8_l <= 9999;block8_r <= 9999;block8_u <= 9999;block8_d <= 9999;
						blk_state[7] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk1_u < ball_centery && blk1_d > ball_centery && blk_state[0])
					begin
						block1_l <= 9999;block1_r <= 9999;block1_u <= 9999;block1_d <= 9999;
						blk_state[0] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx - ball_r) == blk2_r&&(blk_state[1]||blk_state[12]))				//2,13
		begin
			
			ball_ydir <= ball_ydir;
				if(blk2_u < ball_centery && blk2_d > ball_centery && blk_state[1])
					begin
						block2_l <= 9999;block2_r <= 9999;block2_u <= 9999;block2_d <= 9999;
						blk_state[1] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk13_u < ball_centery && blk13_d > ball_centery && blk_state[12])
					begin
						block13_l <= 9999;block13_r <= 9999;block13_u <= 9999;block13_d <= 9999;
						blk_state[12] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx - ball_r) == blk3_r&&(blk_state[2]||blk_state[13]))				//3,14
		begin

			ball_ydir <= ball_ydir;
				if(blk3_u < ball_centery && blk3_d > ball_centery && blk_state[2])
					begin
						block3_l <= 9999;block3_r <= 9999;block3_u <= 9999;block3_d <= 9999;
						blk_state[1] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk14_u < ball_centery && blk14_d > ball_centery && blk_state[13])
					begin
						block14_l <= 9999;block14_r <= 9999;block14_u <= 9999;block14_d <= 9999;
						blk_state[13] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx - ball_r) == blk4_r&&(blk_state[3]||blk_state[14]))				//4,15
		begin
			ball_ydir <= ball_ydir;
				if(blk4_u < ball_centery && blk4_d > ball_centery && blk_state[3])
					begin
						block4_l <= 9999;block4_r <= 9999;block4_u <= 9999;block4_d <= 9999;
						blk_state[3] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk15_u < ball_centery && blk15_d > ball_centery && blk_state[14])
					begin
						block15_l <= 9999;block15_r <= 9999;block15_u <= 9999;block15_d <= 9999;
						blk_state[14] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx - ball_r) == blk5_r&&(blk_state[4]||blk_state[15]))				//5,16
		begin

			ball_ydir <= ball_ydir;
				if(blk5_u < ball_centery && blk5_d > ball_centery && blk_state[4])
					begin
						block5_l <= 9999;block5_r <= 9999;block5_u <= 9999;block5_d <= 9999;
						blk_state[3] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk16_u < ball_centery && blk16_d > ball_centery && blk_state[15])
					begin
						block16_l <= 9999;block16_r <= 9999;block16_u <= 9999;block16_d <= 9999;
						blk_state[15] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx - ball_r) == blk6_r&&(blk_state[5]||blk_state[16]))				//6,17
		begin

			ball_ydir <= ball_ydir;
				if(blk6_u < ball_centery && blk6_d > ball_centery && blk_state[5])
					begin
						block6_l <= 9999;block6_r <= 9999;block6_u <= 9999;block6_d <= 9999;
						blk_state[5] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk15_u < ball_centery && blk15_d > ball_centery && blk_state[16])
					begin
						block17_l <= 9999;block17_r <= 9999;block17_u <= 9999;block17_d <= 9999;
						blk_state[16] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else if((ball_centerx - ball_r) == blk18_r&&(blk_state[6]||blk_state[8]||blk_state[10]||blk_state[17]))				//7,9,11,18
		begin
	
			ball_ydir <= ball_ydir;
				if(blk11_u < ball_centery && blk11_d > ball_centery && blk_state[10])
					begin
						block11_l <= 9999;block11_r <= 9999;block11_u <= 9999;block11_d <= 9999;
						blk_state[10] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk9_u < ball_centery && blk9_d > ball_centery && blk_state[8])
					begin
						block9_l <= 9999;block9_r <= 9999;block9_u <= 9999;block9_d <= 9999;
						blk_state[8] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk18_u < ball_centery && blk18_d > ball_centery && blk_state[17])
					begin
						block18_l <= 9999;block18_r <= 9999;block18_u <= 9999;block18_d <= 9999;
						blk_state[17] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
				else if(blk7_u < ball_centery && blk7_d > ball_centery && blk_state[6])
					begin
						block7_l <= 9999;block7_r <= 9999;block7_u <= 9999;block7_d <= 9999;
						blk_state[6] <= 0;
						ball_xdir <= flag_right;
						if(~gameoverflag)begin m<=m+1;scorespeaker<=1;end else if(gameoverflag)m<=m;
					end
		end
	else
		begin
			ball_xdir <= ball_xdir;
			ball_ydir <= ball_ydir;
			if(m==99)   m<=0; 
			bouncespeaker<=0;
			scorespeaker<=0;
		end
end


always @(posedge clk or posedge reset)
begin
	if(reset)
		ball_centerx <= 200;
	else if(ball_xdir)
		ball_centerx <= ball_centerx+1;
	else 
		ball_centerx <= ball_centerx-1;
end
   
always @(posedge clk or posedge reset )
begin
	if(reset)
		ball_centery <= 400; 
    else if(ball_ydir)
		ball_centery <= ball_centery + 1;
	else
		ball_centery <= ball_centery - 1;
end


reg [31:0] Ball;
always @(*)
begin
	Ball=((hortional_counter-ball_centerx)*(hortional_counter-ball_centerx)+(vertiacl_counter-ball_centery)*(vertiacl_counter-ball_centery));
	if(~gameoverflag)
		begin
			if(Ball <= 100)
				RGB = 3'b101;
			else if(board_cx - half_board_width <= hortional_counter && hortional_counter <= board_cx + half_board_width &&
					board_cy - half_board_height <= vertiacl_counter && vertiacl_counter <= board_cy + half_board_height)
				RGB = 3'b011;
			else if(hortional_counter <= block1_r && hortional_counter >= block1_l && vertiacl_counter <= block1_d && vertiacl_counter >= block1_u ||
					hortional_counter <= block2_r && hortional_counter >= block2_l && vertiacl_counter <= block2_d && vertiacl_counter >= block2_u ||
					hortional_counter <= block3_r && hortional_counter >= block3_l && vertiacl_counter <= block3_d && vertiacl_counter >= block3_u ||
					hortional_counter <= block4_r && hortional_counter >= block4_l && vertiacl_counter <= block4_d && vertiacl_counter >= block4_u ||
					hortional_counter <= block5_r && hortional_counter >= block5_l && vertiacl_counter <= block5_d && vertiacl_counter >= block5_u ||
					hortional_counter <= block6_r && hortional_counter >= block6_l && vertiacl_counter <= block6_d && vertiacl_counter >= block6_u ||
					hortional_counter <= block7_r && hortional_counter >= block7_l && vertiacl_counter <= block7_d && vertiacl_counter >= block7_u ||
					hortional_counter <= block8_r && hortional_counter >= block8_l && vertiacl_counter <= block8_d && vertiacl_counter >= block8_u ||
					hortional_counter <= block9_r && hortional_counter >= block9_l && vertiacl_counter <= block9_d && vertiacl_counter >= block9_u ||
					hortional_counter <= block10_r && hortional_counter >= block10_l && vertiacl_counter <= block10_d && vertiacl_counter >= block10_u ||
					hortional_counter <= block11_r && hortional_counter >= block11_l && vertiacl_counter <= block11_d && vertiacl_counter >= block11_u ||
					hortional_counter <= block12_r && hortional_counter >= block12_l && vertiacl_counter <= block12_d && vertiacl_counter >= block12_u ||
					hortional_counter <= block13_r && hortional_counter >= block13_l && vertiacl_counter <= block13_d && vertiacl_counter >= block13_u ||
					hortional_counter <= block14_r && hortional_counter >= block14_l && vertiacl_counter <= block14_d && vertiacl_counter >= block14_u ||
					hortional_counter <= block15_r && hortional_counter >= block15_l && vertiacl_counter <= block15_d && vertiacl_counter >= block15_u ||
					hortional_counter <= block16_r && hortional_counter >= block16_l && vertiacl_counter <= block16_d && vertiacl_counter >= block16_u ||
					hortional_counter <= block17_r && hortional_counter >= block17_l && vertiacl_counter <= block17_d && vertiacl_counter >= block17_u ||
					hortional_counter <= block18_r && hortional_counter >= block18_l && vertiacl_counter <= block18_d && vertiacl_counter >= block18_u 
					)
				RGB = 3'b111;
			else 
				RGB = 3'b000;
		end
	else
		RGB = 3'b000;

end 














/***************merge from cy*****************/
input level;
wire [15:0]   addr;
reg  [15:0]   addr_res;
reg  [2:0] vga_rgb;
wire [9:0] xpos;
wire [9:0] ypos;
wire clk_25M;
reg clk_25M_res;
assign clk_25M = clk_25M_res;
always@(posedge clk1)
begin
	clk_25M_res <= ~clk_25M_res;
end
VGA_sm u1(clk_25M,reset,hsync,vsync,xpos,ypos);
//-----------------��ʾͼ��-----------------------	  

//parameter level=30;
reg [3:0]level_a;
reg [3:0]level_b;

reg [3:0]score_a;
reg [3:0]score_b;

reg a;
reg b;

always @(posedge clk)
begin
   if(level==1) a<=1;
   else a<=0;
end


reg [6:0]n;

 //n=7'b0;
always @( posedge a or posedge reset)
   begin
     if(reset) n<=1;
   else if(n==99)   n<=0;
   else n<=n+1;
   end
                                
always @ (*)
begin
	  if(n>=0&&n<=99)
		begin
			level_a=(n/10);
			level_b=(n%10);
		end
		
		if(m>=0&&m<=99)
		begin
			score_a=(m/10);
			score_b=(m%10);
		end
		
		
	  if((ypos >= 9'd160 && ypos <= 9'd199)&&(xpos >= 10'd551 && xpos <= 10'd590)) //level shiwei
	    begin
		   case(level_a)
		        0:begin addr_res   <= (ypos-160)*180 + (xpos-551);  end //xianshi 0
		        1:begin addr_res   <= (ypos-160)*180 + (xpos-551)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-160)*180 + (xpos-551)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-160)*180 + (xpos-551)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-160)*180 + (xpos-551)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-160)*180 + (xpos-551)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-160)*180 + (xpos-551)+14440;  end //xianshi 9
		        
		     endcase   
		end         
	  else if((ypos >= 9'd160 && ypos <= 9'd199)&&(xpos >= 10'd591 && xpos <= 10'd630)) //level gewei
	  begin
	  case(level_b)
	            0:begin addr_res   <= (ypos-160)*180 + (xpos-591);  end //xianshi 0
                1:begin addr_res   <= (ypos-160)*180 + (xpos-591)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-160)*180 + (xpos-591)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-160)*180 + (xpos-591)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-160)*180 + (xpos-591)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-160)*180 + (xpos-591)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-160)*180 + (xpos-591)+14440;  end //xianshi 9
	   endcase
	   end    
	  else if((ypos >= 9'd260 && ypos <= 9'd299)&&(xpos >= 10'd551 && xpos <= 10'd590)) //score shiwei
		        //addr_res   <= (ypos-160)*180 + (xpos-551);    //xianshi 0 	   
		  begin
		   case(score_a)
		        0:begin addr_res   <= (ypos-260)*180 + (xpos-551);  end //xianshi 0
		        1:begin addr_res   <= (ypos-260)*180 + (xpos-551)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-260)*180 + (xpos-551)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-260)*180 + (xpos-551)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-260)*180 + (xpos-551)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-260)*180 + (xpos-551)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-260)*180 + (xpos-551)+14440;  end //xianshi 9
		        
		     endcase   
		end              
	  	 else if((ypos >= 9'd260 && ypos <= 9'd299)&&(xpos >= 10'd591 && xpos <= 10'd630)) //score gewei
	  begin
	  case(score_b)
	            0:begin addr_res   <= (ypos-260)*180 + (xpos-591);  end //xianshi 0
                1:begin addr_res   <= (ypos-260)*180 + (xpos-591)+40;  end //xianshi 1
		        2:begin addr_res   <= (ypos-260)*180 + (xpos-591)+80;  end //xianshi 2
		        3:begin addr_res   <= (ypos-260)*180 + (xpos-591)+120;  end //xianshi 3
		        4:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7200;  end //xianshi 4
		        5:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7240;  end //xianshi 5
		        6:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7280;  end //xianshi 6
		        7:begin addr_res   <= (ypos-260)*180 + (xpos-591)+7320;  end //xianshi 7
		        8:begin addr_res   <= (ypos-260)*180 + (xpos-591)+14400;  end //xianshi 8
		        9:begin addr_res   <= (ypos-260)*180 + (xpos-591)+14440;  end //xianshi 9
	   endcase
	   end    
		        
	  else if((ypos >= 9'd210 && ypos <= 9'd249)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-210)*180 + (xpos-551)+14480;    //xianshi fenshu 
	 else if((ypos >= 9'd319 && ypos <= 9'd400)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-319)*180 + (xpos-551)+50400;    //xianshi beijing 
	else if((ypos >= 9'd11 && ypos <= 9'd90)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-11)*180 + (xpos-551)+50400+80;    //xianshi tou 	        
		
	 else if((ypos >= 9'd110 && ypos <= 9'd149)&&(xpos >= 10'd551 && xpos <= 10'd630))
		        addr_res   <= (ypos-110)*180 + (xpos-551)+21600;    //xianshi LEVEL 
	 
	 else if((ypos >= 9'd0 && ypos <= 9'd239)&&(xpos >= 10'd541 && xpos <= 10'd550))
		        addr_res   <= (ypos-0)*180 + (xpos-541)+160;    //xianshi gan10 
		        
      else if((ypos >= 9'd240 && ypos <= 9'd479)&&(xpos >= 10'd541 && xpos <= 10'd550))
		        addr_res   <= (ypos-240)*180 + (xpos-541)+170;    //xianshi gan11  
	 
	 else if((ypos >= 9'd0 && ypos <= 9'd239)&&(xpos >= 10'd631 && xpos <= 10'd640))
		        addr_res   <= (ypos-0)*180 + (xpos-631)+160;    //xianshi gan20 
		        
      else if((ypos >= 9'd240 && ypos <= 9'd479)&&(xpos >= 10'd631 && xpos <= 10'd640))
		        addr_res   <= (ypos-240)*180 + (xpos-631)+170;    //xianshi gan21  
	 
	 else if((ypos >= 9'd240 && ypos <= 9'd359)&&(xpos >= 10'd240 && xpos <= 10'd399)&&gameoverflag&&(~guoguanflag))
		        addr_res   <= (ypos-240)*180 + (xpos-240)+28800;    //xianshi GAME OVER	   
	 else if((ypos >= 9'd240 && ypos <= 9'd279)&&(xpos >= 10'd240 && xpos <= 10'd319)&&guoguanflag&&gameoverflag)
		        addr_res   <= (ypos-240)*180 + (xpos-240)+21680;    //xianshi guoguan	          
	 else addr_res <=0;
		
end
assign addr = addr_res;

 rom1
	(
		addr,
		clk_25M,
		RGBx
	);  
	
	
	
// level 2	
	
	

                          ////RGB0/////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
reg [9:0]lx1,ly1;
reg lx_dir1;
reg ly_dir1;
reg lover1;

reg [2:0]ls1;     ////remember the statement of ball
reg [2:0]ls2;
reg [2:0]ls3;
reg [2:0]ls4;


reg   [32:0]lblock1_x;
reg   [32:0]lblock1_y;
reg   [32:0]lblock2_x;
reg   [32:0]lblock2_y;
reg   [32:0]lblock3_x;
reg   [32:0]lblock3_y;
reg   [32:0]lblock4_x;
reg   [32:0]lblock4_y;

reg   [9:0] lx_board1;
reg   [9:0] ly_board1;

parameter lby_board1 = 468;

always @(posedge clk or posedge reset ) 
begin
	if(reset) 
		begin
			lx_board1 <= 270;
			ly_board1 <= 448;
		end
	else if(n==2)
		if(1)		
			begin
				if(ps2_state)
				tmpbytes = ps2_byte;
			else
				tmpbytes = 8'b0;
			if(tmpbytes == "A") //button2
					begin
						if(lx_board1 <=65) 
							lx_board1 <= lx_board1;
						else 
							lx_board1 <= lx_board1 - 1;
					end

				 if(tmpbytes == "D") //button1
					begin
						if(lx_board1 >= 539 - 65)
							lx_board1 <= lx_board1;
						else 
							lx_board1 <= lx_board1 + 1;
					end
				  if(tmpbytes == "W")
					begin
						if(ly_board1 <=418  )
							ly_board1 <= ly_board1;
						else 
							ly_board1 <= ly_board1 - 1;
					end
					if(tmpbytes == "S")
					begin
						if(ly_board1 >=448) 
							ly_board1 <= ly_board1;
						else 
							ly_board1 <= ly_board1 + 1;
					end

			end
end

always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			ly_dir1 <=0;
			lx_dir1 <=0;
			lblock1_x<=100;
			lblock1_y<=50;
			lblock2_x<=390;
			lblock2_y<=50;
			lblock3_x<=100;
			lblock3_y<=150;
			lblock4_x<=390;
			lblock4_y<=150;
			ls1<=0;
		    ls2<=0;
		    ls3<=0;
		    ls4<=0;
		    lover1<=0;
		end

	else if (ly1<=20)		//ball zhuang shang xian
		ly_dir1 <=1;
	else if (ly1>=458)       //zhuang xia xian
		ly_dir1 <= 0;

	else if (lx1<=20)		//zhuang zuo xian
		lx_dir1 <=1;
	else if (lx1>=518)		//zhuang you xian
		lx_dir1 <= 0;

	else if(ly1>=ly_board1-10)        ///xia banzi
		begin 
			if(lx_board1-55<=lx1 && lx1<=lx_board1+55)		//zhuang dao ban zi shang
				begin
					ly_dir1 <= 0;
					lx_dir1 <= lx_dir1;
				end
			else
				lover1<=1;					
		end
		

///////////////////////////////////////////////////////
/******************lblock1 up**************************/    
	else if(ly1==lblock1_y-10 && lblock1_x<lx1 && lx1<lblock1_x+50) 
		begin 
			ly_dir1 <= 0; 
			lx_dir1 <= lx_dir1;
            ls1<=ls1+1;
            if(ls1==4)
				begin
					lblock1_x<=9999999;
					lblock1_y<=9999999;
		        end
				
		end
    
/******************lblock1 bottom**************************/
	else if(ly1==lblock1_y+50+10 && lblock1_x<lx1 && lx1<lblock1_x+50) 
		begin 
			ly_dir1 <= 1; 
			lx_dir1 <= lx_dir1;
			ls1<=ls1+1;
            if(ls1==4)
				begin
					lblock1_x<=9999999;
					lblock1_y<=9999999;
		        end
		end
/******************lblock1 left**************************/
	else if(lx1==lblock1_x+10 && lblock1_y<ly1 && ly1<lblock1_y+50) 
		begin 
			ly_dir1 <= ly_dir1; 
			lx_dir1 <= 0;
			ls1<=ls1+1;
            if(ls1==4)
				begin
					lblock1_x<=9999999;
					lblock1_y<=9999999;
		        end
		end
    
/****************lblock1 right**************************/
	else if(lx1==lblock1_x+50+10 && lblock1_y<ly1 && ly1<lblock1_y+50) 
		begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 1;
		ls1<=ls1+1;
            if(ls1==4)
				begin
					lblock1_x<=9999999;
					lblock1_y<=9999999;
		        end
	end

   ///////////////////////////////////////////////////////
/******************lblock2 up**************************/    
	else if(ly1==lblock2_y-10 && lblock2_x<lx1 && lx1<lblock2_x+50) 
		begin 
			ly_dir1 <= 0; 
			lx_dir1 <= lx_dir1;
			ls2<=ls2+1;
            if(ls2==4)
				begin
					lblock2_x<=9999999;
					lblock2_y<=9999999;
		        end
	end
    
/******************lblock2 bottom**************************/
else if(ly1==lblock2_y+50+10 && lblock2_x<lx1 && lx1<lblock2_x+50) 
    begin 
		ly_dir1 <= 1; 
		lx_dir1 <= lx_dir1;
		ls2<=ls2+1;
            if(ls2==4)
				begin
					lblock2_x<=9999999;
					lblock2_y<=9999999;
		        end
	end
/******************lblock2 left**************************/
else if(lx1==lblock2_x+10 && lblock2_y<ly1 && ly1<lblock2_y+50) 
    begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 0;
		ls2<=ls2+1;
            if(ls2==4)
				begin
					lblock2_x<=9999999;
					lblock2_y<=9999999;
		        end
	end
    
/******************lblock2 right**************************/
else if(lx1==lblock2_x+50+10 && lblock2_y<ly1 && ly1<lblock2_y+50) 
    begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 1;
		ls2<=ls2+1;
            if(ls2==4)
				begin
					lblock2_x<=9999999;
					lblock2_y<=9999999;
		        end
	end

   ///////////////////////////////////////////////////////
/******************lblock3 up**************************/    
else if(ly1==lblock3_y-10 && lblock3_x<lx1 && lx1<lblock3_x+50) 
    begin 
		ly_dir1 <= 0; 
		lx_dir1 <= lx_dir1;
		ls3<=ls3+1;
            if(ls3==4)
				begin
					lblock3_x<=9999999;
					lblock3_y<=9999999;
		        end
	end
    
/******************lblock3 bottom**************************/
else if(ly1==lblock3_y+50+10 && lblock3_x<lx1 && lx1<lblock3_x+50) 
   begin 
		ly_dir1 <= 1; 
		lx_dir1 <= lx_dir1;
		ls3<=ls3+1;
            if(ls3==4)
				begin
					lblock3_x<=9999999;
					lblock3_y<=9999999;
		        end
	end
//******************lblock3 left**************************/
else if(lx1==lblock3_x+10 && lblock3_y<ly1 && ly1<lblock3_y+50) 
    begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 0;
		ls3<=ls3+1;
            if(ls3==4)
				begin
					lblock3_x<=9999999;
					lblock3_y<=9999999;
		        end
	end
    
/******************lblock3 right**************************/
else if(lx1==lblock3_x+50+10 && lblock3_y<ly1 && ly1<lblock3_y+50) 
    begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 1;
		ls3<=ls3+1;
            if(ls3==4)
				begin
					lblock3_x<=9999999;
					lblock3_y<=9999999;
		        end
	end

   ///////////////////////////////////////////////////////
/******************lblock4 up**************************/    
  else if(ly1==lblock4_y-10 && lblock4_x<lx1 && lx1<lblock4_x+50) 
    begin 
		ly_dir1 <= 0; 
		lx_dir1 <= lx_dir1;
		ls4<=ls4+1;
            if(ls4==4)
				begin
					lblock4_x<=9999999;
					lblock4_y<=9999999;
		        end
	end
    
/******************lblock4 bottom**************************/
 else if(ly1==lblock4_y+50+10 && lblock4_x<lx1 && lx1<lblock4_x+50) 
    begin 
		ly_dir1 <= 1; 
		lx_dir1 <= lx_dir1;
		ls4<=ls4+1;
            if(ls4==4)
				begin
					lblock4_x<=9999999;
					lblock4_y<=9999999;
		        end
	end  
/******************lblock4 left**************************/
 else if(lx1==lblock4_x+10 && lblock4_y<ly1 && ly1<lblock4_y+50) 
    begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 0;
		ls4<=ls4+1;
            if(ls4==4)
				begin
					lblock4_x<=9999999;
					lblock4_y<=9999999;
		        end
	end
    
/******************lblock4 right**************************/
  else if(lx1==lblock4_x+50+10 && lblock4_y<ly1 && ly1<lblock4_y+50) 
    begin 
		ly_dir1 <= ly_dir1; 
		lx_dir1 <= 1;
		ls4<=ls4+1;
            if(ls4==4)
				begin
					lblock4_x<=9999999;
					lblock4_y<=9999999;
		        end
		end


/***************************duijiaoxian**************/
	else if(lx_dir1==1&&ly_dir1==1)                
		begin
			if(((lblock1_x-lx1)*(lblock1_x-lx1)+(lblock1_y-ly1)*(lblock1_y-ly1))<=100)
				begin
					lx_dir1<=~lx_dir1;
					ly_dir1<=~ly_dir1;
					ls1<=ls1+1;
					if(ls1==4)
						begin
							lblock1_x<=9999999;
							lblock1_y<=9999999;
						end	
                end 
             else if(((lblock2_x-lx1)*(lblock2_x-lx1)+(lblock2_y-ly1)*(lblock2_y-ly1))<=100)
				begin
					lx_dir1<=~lx_dir1;
					ly_dir1<=~ly_dir1;
					ls2<=ls2+1;
					if(ls2==4)
						begin
							lblock2_x<=9999999;
							lblock2_y<=9999999;
						end	
                end  
               else if(((lblock3_x-lx1)*(lblock3_x-lx1)+(lblock3_y-ly1)*(lblock3_y-ly1))<=100)
				begin
					lx_dir1<=~lx_dir1;
					ly_dir1<=~ly_dir1;
					ls3<=ls3+1;
					if(ls3==4)
						begin
							lblock3_x<=9999999;
							lblock3_y<=9999999;
						end	
                end
                else if(((lblock4_x-lx1)*(lblock4_x-lx1)+(lblock4_y-ly1)*(lblock4_y-ly1))<=100)
				begin
					lx_dir1<=~lx_dir1;
					ly_dir1<=~ly_dir1;
					ls4<=ls4+1;
					if(ls4==4)
						begin
							lblock4_x<=9999999;
							lblock4_y<=9999999;
						end	
                end     
        end	
    else if(lx_dir1==0&&ly_dir1==1)
			begin
				if(((lblock1_x+50-lx1)*(lblock1_x+50-lx1)+(lblock1_y-ly1)*(lblock1_y-ly1))<=100)
					begin
						lx_dir1<=~lx_dir1;
						ly_dir1<=~ly_dir1;
						ls1<=ls1+1;
						if(ls1==4)
							begin
								lblock1_x<=9999999;
								lblock1_y<=9999999;
							end	
					end 
				else if(((lblock2_x+50-lx1)*(lblock2_x+50-lx1)+(lblock2_y-ly1)*(lblock2_y-ly1))<=100)
					begin
						lx_dir1<=~lx_dir1;
						ly_dir1<=~ly_dir1;
						ls2<=ls2+1;
						if(ls2==4)
							begin
								lblock2_x<=9999999;
								lblock2_y<=9999999;
							end	
					end 
				else if(((lblock3_x+50-lx1)*(lblock3_x+50-lx1)+(lblock3_y-ly1)*(lblock3_y-ly1))<=100)
					begin
						lx_dir1<=~lx_dir1;
						ly_dir1<=~ly_dir1;
						ls3<=ls3+1;
						if(ls3==4)
							begin
								lblock3_x<=9999999;
								lblock3_y<=9999999;
							end	
					end
				else if(((lblock4_x+50-lx1)*(lblock4_x+50-lx1)+(lblock4_y-ly1)*(lblock4_y-ly1))<=100)
					begin
						lx_dir1<=~lx_dir1;
						ly_dir1<=~ly_dir1;
						ls4<=ls4+1;
						if(ls4==4)
							begin
								lblock4_x<=9999999;
								lblock4_y<=9999999;
							end	
					end 	 		
            end
      else if(lx_dir1==1&&ly_dir1==0)
				begin
					if(((lblock1_x-lx1)*(lblock1_x-lx1)+(lblock1_y+50-ly1)*(lblock1_y+50-ly1))<=100)
						begin
							lx_dir1<=~lx_dir1;
							ly_dir1<=~ly_dir1;
							ls1<=ls1+1;
							if(ls1==4)
								begin
									lblock1_x<=9999999;
									lblock1_y<=9999999;
								end	
						end
					else if(((lblock2_x-lx1)*(lblock2_x-lx1)+(lblock2_y+50-ly1)*(lblock2_y+50-ly1))<=100)
						begin
							lx_dir1<=~lx_dir1;
							ly_dir1<=~ly_dir1;
							ls2<=ls2+1;
							if(ls2==4)
								begin
									lblock2_x<=9999999;
									lblock2_y<=9999999;
								end	
						end
					else if(((lblock3_x-lx1)*(lblock3_x-lx1)+(lblock3_y+50-ly1)*(lblock3_y+50-ly1))<=100)
						begin
							lx_dir1<=~lx_dir1;
							ly_dir1<=~ly_dir1;
							ls3<=ls3+1;
							if(ls3==4)
								begin
									lblock3_x<=9999999;
									lblock3_y<=9999999;
								end	
						end
					else if(((lblock4_x-lx1)*(lblock4_x-lx1)+(lblock4_y+50-ly1)*(lblock4_y+50-ly1))<=100)
						begin
							lx_dir1<=~lx_dir1;
							ly_dir1<=~ly_dir1;
							ls4<=ls4+1;
							if(ls4==4)
								begin
									lblock4_x<=9999999;
									lblock4_y<=9999999;
								end	
						end 	 	 	 
                end
           else if(lx_dir1==0&&ly_dir1==0)
					begin
						if(((lblock1_x+50-lx1)*(lblock1_x+50-lx1)+(lblock1_y+50-ly1)*(lblock1_y+50-ly1))<=100)
							begin
								lx_dir1<=~lx_dir1;
								ly_dir1<=~ly_dir1;
								ls1<=ls1+1;
								if(ls1==4)
									begin
										lblock1_x<=9999999;
										lblock1_y<=9999999;
									end	
							end 
						else if(((lblock2_x+50-lx1)*(lblock2_x+50-lx1)+(lblock2_y+50-ly1)*(lblock2_y+50-ly1))<=100)
							begin
								lx_dir1<=~lx_dir1;
								ly_dir1<=~ly_dir1;
								ls2<=ls2+1;
								if(ls2==4)
									begin
										lblock2_x<=9999999;
										lblock2_y<=9999999;
									end	
							end
						else if(((lblock3_x+50-lx1)*(lblock3_x+50-lx1)+(lblock3_y+50-ly1)*(lblock3_y+50-ly1))<=100)
							begin
								lx_dir1<=~lx_dir1;
								ly_dir1<=~ly_dir1;
								ls3<=ls3+1;
								if(ls3==4)
									begin
										lblock3_x<=9999999;
										lblock3_y<=9999999;
									end	
							end
						else if(((lblock4_x+50-lx1)*(lblock4_x+50-lx1)+(lblock4_y+50-ly1)*(lblock4_y+50-ly1))<=100)
							begin
								lx_dir1<=~lx_dir1;
								ly_dir1<=~ly_dir1;
								ls4<=ls4+1;
								if(ls4==4)
									begin
										lblock4_x<=9999999;
										lblock4_y<=9999999;
									end	
							end 	 	 	
                    end
 
end	
/////////////////////////////////////////
always @(posedge clk or posedge reset)
begin
	if (reset)
		lx1<=400;
	else
		begin
			if(lover1==0)	
				begin
				    if(lx_dir1)
						lx1 <=lx1+1;
					else
						lx1<=lx1-1;
				end	
			else
				begin
					lx1<=lx1;
				end		
		end				
end

always @(posedge clk or posedge reset )
begin
	if (reset)
		ly1 <= 400; 
    else
		begin
			if(lover1==0)	
				begin
				    if(ly_dir1)
						ly1 <=ly1+1;
					else
						ly1<=ly1-1;
				end	
			else
				begin
					ly1<=ly1;
				end		
		end		
end


/******draw RGB0*******/
reg [31:0] LB;
always @(hortional_counter or vertiacl_counter )
begin
     LB=((hortional_counter-lx1)*(hortional_counter-lx1)+(vertiacl_counter-ly1)*(vertiacl_counter-ly1));
     if(LB<=100) 
		RGB0=3'b011;//ball

     else if (lx_board1-55<=hortional_counter && hortional_counter <= lx_board1+55 &&
           ly_board1<=vertiacl_counter && vertiacl_counter <= lby_board1)
		RGB0=3'b101;//board
     //else if((hortional_counter==49||hortional_counter==101||hortional_counter==439||hortional_counter==491)&&
      //       ((49<=vertiacl_counter&&vertiacl_counter<=101)||(149<=vertiacl_counter&&vertiacl_counter<=201)))
      //  RGB0=8'b00000000;             //draw black line
    // else if((vertiacl_counter==49||vertiacl_counter==151||vertiacl_counter==149||vertiacl_counter==201)&&
    //          ((49<=hortional_counter&&hortional_counter<=101)||(439<=hortional_counter&&hortional_counter<=491)))
	//	RGB0=8'b00000000;                //draw black line	 	
     else if (lblock1_x<=hortional_counter && hortional_counter <= lblock1_x+50 &&  //block1
           lblock1_y<=vertiacl_counter && vertiacl_counter <=lblock1_y+50 )
		begin
			case(ls1)
				0:
					RGB0=3'b000;
				1:
					RGB0=3'b100;
				2:
				    RGB0=3'b011;
				3:
					RGB0=3'b010;
			endcase					
        end 
     else if (lblock2_x<=hortional_counter && hortional_counter <= lblock2_x+50 &&
          lblock2_y<=vertiacl_counter && vertiacl_counter <=lblock2_y+50 )          //block2
		 begin
				case(ls2)
					0:
					RGB0=3'b000;
				1:
					RGB0=3'b100;
				2:
				    RGB0=3'b011;
				3:
					RGB0=3'b010;
				endcase					
			end 
    
     else if (lblock3_x<=hortional_counter && hortional_counter <=lblock3_x+50 &&
           lblock3_y<=vertiacl_counter && vertiacl_counter <=lblock3_y+50)      //block3
		 begin
				case(ls3)
					0:
					RGB0=3'b000;
				1:
					RGB0=3'b100;
				2:
				    RGB0=3'b011;
				3:
					RGB0=3'b010;
				endcase					
			end 
      
     else if (lblock4_x<=hortional_counter && hortional_counter <= lblock4_x+50 &&
           lblock4_y<=vertiacl_counter && vertiacl_counter <=lblock4_y+50)
		 begin                                                      //block4
				case(ls4)
					0:
					RGB0=3'b000;
				1:
					RGB0=3'b100;
				2:
				    RGB0=3'b011;
				3:
					RGB0=3'b010;
				endcase					
			end 
	 else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
	 		
	 		RGB0= 3'b010;  // draw bian kuang
	 else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
	 		RGB0= 8'b10010010;  // draw bian kuang
	 else if(0<=hortional_counter && hortional_counter <= 539
				   && 0<=vertiacl_counter && vertiacl_counter <= 120 )
			RGB0 = 3'b111;              ////DRAW background
		   
	else if(0<=hortional_counter && hortional_counter <= 539
					  && 121<=vertiacl_counter && vertiacl_counter <= 240 )
			RGB0 = 3'b111;
			
	else if(0<=hortional_counter && hortional_counter <= 539 
			  && 241<=vertiacl_counter && vertiacl_counter <= 360 )
			RGB0 = 3'b000;
			
	else if(0<=hortional_counter && hortional_counter <= 539 
			  && 361<=vertiacl_counter && vertiacl_counter <= 479)
			RGB0 = 3'b111;
	else 
		RGB0=3'b000;//others-black
end 	
	
	
	
Music music(.clk(clk1),.music_en(bouncespeaker),.Score_Music_En(scorespeaker),.speaker(speker));



//level 3

  ////RGB1  people/////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
reg   [9:0] lx_boardu;
reg   [9:0] lx_boardd;
reg [31:0] LC;
reg [1:0] lgs;
reg [3:0]j;
parameter lby_boardu=11;
parameter ly_boardu=31;
parameter lby_boardd=468;
parameter ly_boardd=448;

parameter color1 =3'b000;
parameter color2 =3'b010;
parameter color3 =3'b011;
parameter color4 =3'b001;

reg lx_dir2;
reg ly_dir2;
reg [9:0]lx2,ly2;
reg lover2;

reg[5:0] drawmap1;       ////map of hust
reg[5:0] drawmap2;
reg[5:0] drawmap3;
reg[5:0] drawmap4;

reg[5:0] drawmap5;
reg[5:0] drawmap6;
reg[5:0] drawmap7;
reg[5:0] drawmap8;

reg[5:0] drawmap9;
reg[5:0] drawmap10;
reg[5:0] drawmap11;
reg[5:0] drawmap12;

reg[5:0] drawmap13;
reg[5:0] drawmap14;
reg[5:0] drawmap15;


always @(posedge clk or posedge reset ) 
begin
	if(reset) 
		begin
			lx_boardd <= 270;
			lx_boardu <= 270;
		end
	else 
		if(1)		
			begin
				if(ps2_state)
				tmpbytes = ps2_byte;
			else
				tmpbytes = 8'b0;
			if(tmpbytes == "A")  //button2
					begin
						if(lx_boardd <=65) 
							lx_boardd <= lx_boardd;
						else 
							lx_boardd <= lx_boardd - 1;
					end

				 if(tmpbytes == "D") //button1
					begin
						if(lx_boardd >= 539 - 65)
							lx_boardd <= lx_boardd;
						else 
							lx_boardd <= lx_boardd + 1;
					end
				  if(tmpbytes == "H")
					begin
						if(lx_boardu >=539-65  )
							lx_boardu <= lx_boardu;
						else 
							lx_boardu <= lx_boardu + 1;
					end
					if(tmpbytes == "F")
					begin
						if(lx_boardu <=65) 
							lx_boardu <= lx_boardu;
						else 
							lx_boardu <= lx_boardu - 1;
					end

			end
end

always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			ly_dir2 <=0;
			lx_dir2 <=0;
		    lover2<=0;
		    lgs<=0;
		    
		    drawmap1 <=6'b111110;
		    drawmap2 <=6'b100000;
		    drawmap3 <=6'b100000;
		    drawmap4 <=6'b000000;
		    drawmap5 <=6'b111110;
		    drawmap6 <=6'b100010;
		    drawmap7 <=6'b111110;
		    drawmap8 <=6'b000000;
		    drawmap9 <=6'b101110;
		    drawmap10<=6'b101010;
		    drawmap11<=6'b111010;
		    drawmap12<=6'b000000;
		    drawmap13<=6'b111110;
		    drawmap14<=6'b101010;
		    drawmap15<=6'b101010;
		                 
		end
		
	else if(ly2>=449-10)        ///xia banzi
		begin 
			if(lx_boardd-55<=lx2 && lx2<=lx_boardd+55)		//zhuang dao ban zi shang
				begin
					ly_dir2 <= 0;
					lx_dir2 <= lx_dir2;
					//lgs<=0;
				end
			else
				begin
					lover2<=1;
					lgs<=1;
				end										
		end
	else if(ly2<=30+10)        ///shang banzi
		begin 
			if(lx_boardu-55<=lx2 && lx2<=lx_boardu+55)		//zhuang dao ban zi shang
				begin
					ly_dir2 <= 1;
					lx_dir2 <= lx_dir2;
					//lgs<=0;
				end
			else
				begin
					lover2<=1;
					lgs<=2;
				end										
		end	
	else if (lx2<=20)		//zhuang zuo xian
		lx_dir2 <=1;

	else if (lx2>=518)		//zhuang you xian
		lx_dir2<= 0;
	
end	


always @(posedge clk or posedge reset )
begin
	if (reset)
		ly2 <= 420; 
    else
		begin
			if(lover2==0)	
				begin
				    if(ly_dir2)
						ly2 <=ly2+1;
					else
						ly2<=ly2-1;
				end	
			else
				begin
					ly2<=ly2;
				end		
		end		
end	


always @(posedge clk or posedge reset )
begin
	if (reset)
		lx2 <= 500; 
    else
		begin
			if(lover2==0)	
				begin
				    if(lx_dir2)
						lx2 <=lx2+1;
					else
						lx2<=lx2-1;
				end	
			else
				begin
					lx2<=lx2;
				end		
		end		
end

always @(hortional_counter or vertiacl_counter )
begin
     LC=((hortional_counter-lx2)*(hortional_counter-lx2)+(vertiacl_counter-ly2)*(vertiacl_counter-ly2));
     if(lgs==1)
		begin
			if((35<=hortional_counter && hortional_counter <=494)&&(241<=vertiacl_counter && vertiacl_counter <= 420))
			   j<=(vertiacl_counter-241)/30; 
			
			if((((hortional_counter-265)*(hortional_counter-265)+(vertiacl_counter-140)*(vertiacl_counter-140))<=75*75)&&
		         vertiacl_counter>=180)
		         RGB1=color1;
			else if(((hortional_counter-225)*(hortional_counter-225)+(vertiacl_counter-100)*(vertiacl_counter-100))<=100)
				 RGB1=color1;	
			else if(((hortional_counter-305)*(hortional_counter-305)+(vertiacl_counter-100)*(vertiacl_counter-100))<=100)
				 RGB1=color1;	 
			else if ((drawmap1[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+1<= hortional_counter && hortional_counter <= 35+29))
				RGB1=color1;
			else if ((drawmap2[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+31<= hortional_counter && hortional_counter <= 35+59))
				RGB1=color1;
			else if ((drawmap3[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+61<= hortional_counter && hortional_counter <= 35+89))
				RGB1=color1;
			else if ((drawmap4[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+91<= hortional_counter && hortional_counter <= 35+119))
				RGB1=color2;
			else if ((drawmap5[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
					35+121<= hortional_counter && hortional_counter <= 35+149))
				RGB1=color2;
			else if ((drawmap6[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+151<= hortional_counter && hortional_counter <= 35+179))
				RGB1=color2;
			else if ((drawmap7[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+181<= hortional_counter && hortional_counter <= 35+209))
				RGB1=color2;
			else if ((drawmap8[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+211<= hortional_counter && hortional_counter <= 35+239))
				RGB1=color3;
			else if ((drawmap9[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+241<= hortional_counter && hortional_counter <= 35+269))
				RGB1=color3;
			else if ((drawmap10[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+271<= hortional_counter && hortional_counter <= 35+299))
				RGB1=color3;
			else if ((drawmap11[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+301<= hortional_counter && hortional_counter <= 35+329))
				RGB1=color3;	
			else if ((drawmap12[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+331<= hortional_counter && hortional_counter <=35+359))
				RGB1=color4;
			else if ((drawmap13[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+361<= hortional_counter && hortional_counter <=35+389))
				RGB1=color4;	
			else if ((drawmap14[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+391<= hortional_counter && hortional_counter <=35+419))
				RGB1=color4;
			else if ((drawmap15[j])&&(((240+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(240+30*j+29))&&
						35+421<= hortional_counter && hortional_counter <=35+449))
				RGB1=color4;	  
			 else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
					
					RGB1= 3'b010;  // draw bian kuang
			 else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
					RGB1= 3'b011;  // draw bian kuang
			 else if(11<=hortional_counter && hortional_counter <= 529
						   && 11<=vertiacl_counter && vertiacl_counter <=239)
					RGB1 = 3'b101;              ////DRAW background
				   
			 else if(11<=hortional_counter && hortional_counter <= 529
							  && 241<=vertiacl_counter && vertiacl_counter <= 469 )
					RGB1 = 3'b111;
			 else
				begin
					RGB1=3'b000;//others-black
				end
		end	
        
     else if(lgs==2)
		begin
			if((35<=hortional_counter && hortional_counter <=494)&&(11<=vertiacl_counter && vertiacl_counter <= 190))
			   j<=(vertiacl_counter-11)/30; 
			
			if((((hortional_counter-265)*(hortional_counter-265)+(vertiacl_counter-370)*(vertiacl_counter-370))<=75*75)&&
		         vertiacl_counter>=410)
		         RGB1=color1;                     //laugh face
			else if(((hortional_counter-225)*(hortional_counter-225)+(vertiacl_counter-330)*(vertiacl_counter-330))<=100)
				 RGB1=color1;	                 //laugh face
			else if(((hortional_counter-305)*(hortional_counter-305)+(vertiacl_counter-330)*(vertiacl_counter-330))<=100)
				 RGB1=color1;	                 //laugh face
			else if ((drawmap1[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+1<= hortional_counter && hortional_counter <= 35+29))
				RGB1=color1;
			else if ((drawmap2[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+31<= hortional_counter && hortional_counter <= 35+59))
				RGB1=color1;
			else if ((drawmap3[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+61<= hortional_counter && hortional_counter <= 35+89))
				RGB1=color1;
			else if ((drawmap4[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+91<= hortional_counter && hortional_counter <= 35+119))
				RGB1=color2;
			else if ((drawmap5[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
					35+121<= hortional_counter && hortional_counter <= 35+149))
				RGB1=color2;
			else if ((drawmap6[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+151<= hortional_counter && hortional_counter <= 35+179))
				RGB1=color2;
			else if ((drawmap7[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+181<= hortional_counter && hortional_counter <= 35+209))
				RGB1=color2;
			else if ((drawmap8[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+211<= hortional_counter && hortional_counter <= 35+239))
				RGB1=color3;
			else if ((drawmap9[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+241<= hortional_counter && hortional_counter <= 35+269))
				RGB1=color3;
			else if ((drawmap10[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+271<= hortional_counter && hortional_counter <= 35+299))
				RGB1=color3;
			else if ((drawmap11[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+301<= hortional_counter && hortional_counter <= 35+329))
				RGB1=color3;	
			else if ((drawmap12[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+331<= hortional_counter && hortional_counter <=35+359))
				RGB1=color4;
			else if ((drawmap13[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+361<= hortional_counter && hortional_counter <=35+389))
				RGB1=color4;	
			else if ((drawmap14[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+391<= hortional_counter && hortional_counter <=35+419))
				RGB1=color4;
			else if ((drawmap15[j])&&(((10+30*j+1)<=vertiacl_counter&&vertiacl_counter<=(10+30*j+29))&&
						35+421<= hortional_counter && hortional_counter <=35+449))
				RGB1=color4;	  
			 else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
					
					RGB1= 3'b010;  // draw bian kuang
			 else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
					RGB1= 3'b011;  // draw bian kuang
			 else if(11<=hortional_counter && hortional_counter <= 529
						   && 11<=vertiacl_counter && vertiacl_counter <=239  )
					RGB1 = 3'b101;              ////DRAW background
				   
			 else if(11<=hortional_counter && hortional_counter <= 529
							  && 241<=vertiacl_counter && vertiacl_counter <= 469 )
					RGB1 = 3'b111;
			 else
				begin
					RGB1=3'b000;//others-black
				end
		end	
      

         else
			 begin
				 if(LC<=100) 
					RGB1=3'b110;//ball

				 else if (lx_boardu-55<=hortional_counter && hortional_counter <= lx_boardu+55 &&
						lby_boardu<=vertiacl_counter && vertiacl_counter <= ly_boardu)
					RGB1=3'b001;//shangboard
				 else if (lx_boardd-55<=hortional_counter && hortional_counter <= lx_boardd+55 &&
						ly_boardd<=vertiacl_counter && vertiacl_counter <= lby_boardd)
					RGB1=3'b110;//xiaboard
				 else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
						
						RGB1= 3'b010;  // draw bian kuang
				 else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
						RGB1= 3'b010;  // draw bian kuang
				 else if(11<=hortional_counter && hortional_counter <= 529
							   && 11<=vertiacl_counter && vertiacl_counter <=239  )
						RGB1 = 3'b011;              ////DRAW background
					   
				 else if(11<=hortional_counter && hortional_counter <= 529
								  && 241<=vertiacl_counter && vertiacl_counter <= 469 )
						RGB1 = 3'b111;
				 else
					begin
						RGB1=3'b000;//others-black
					end
			end		
	
end 






//level 4


    ////RGB2  people   vs machine/////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

reg   [9:0] lx_boardu3;
reg   [9:0] lx_boardd3;
reg   [9:0] ly_boardd3;
reg   [31:0] LD;
reg [1:0] lgs3;

reg lx_dir3;
reg ly_dir3;
reg [9:0]lx3,ly3;
reg lover3;
reg [9:0]lpc;

always @(posedge ly_dir3 or posedge reset)
begin
	if(reset)
		lpc<=0;
	else if(ly_dir3) 
		lpc<=lpc+10;
	else	
	   lpc<=lpc;
end

always @(posedge clk or posedge reset ) 
begin
	if(reset) 
		begin
			lx_boardd3 <= 270;
			lx_boardu3 <= 270;
			ly_boardd3 <=448;
		end
	else
	 begin 		
			if(ps2_state)
				tmpbytes = ps2_byte;
			else
				tmpbytes = 8'b0;
			if(tmpbytes == "A") //button2
					begin
						if(lx_boardd3 <=65) 
							lx_boardd3 <= lx_boardd3;
						else 
							lx_boardd3 <= lx_boardd3 - 1;
					end

				 if(tmpbytes == "D") //button1
					begin
						if(lx_boardd3 >= 539 - 65)
							lx_boardd3 <= lx_boardd3;
						else 
							lx_boardd3 <= lx_boardd3 + 1;
					end
				  if(tmpbytes == "W")
					begin
						if(ly_boardd3 >=418  )
							ly_boardd3 <= ly_boardd3-1;
						else 
							ly_boardd3 <= ly_boardd3;
					end
				  if(tmpbytes == "S")
					begin
						if(ly_boardd3 >=448) 
							ly_boardd3 <= ly_boardd3;
						else 
							ly_boardd3 <= ly_boardd3 + 1;
					end
				 if(lx_dir3)
					begin
						if(lx3-lpc>=539-65)
							lx_boardu3<=lx_boardu3;
						else if(lx3-lpc<=65)
							     lx_boardu3<=65;
						else
							 lx_boardu3<=lx3-lpc;	
			        end
			      else if(~lx_dir3)
						begin
							if(lx3+lpc<=65)
								lx_boardu3<=lx_boardu3;
							else if(lx3+lpc>=539-65)
							     lx_boardu3<=539-65;
							else
							 lx_boardu3<=lx3+lpc;	
			            end
		
			end
end
always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			ly_dir3 <=0;
			lx_dir3 <=0;
		    lover3<=0;
		    lgs3<=0;		                 
		end
		
	else if(ly3>=ly_boardd3-10)        ///xia banzi
		begin 
			if(lx_boardd3-55<=lx3 && lx3<=lx_boardd3+55)		//zhuang dao ban zi shang
				begin
					ly_dir3 <= 0;
					lx_dir3 <= lx_dir3;
					
				end
			else
				begin
					lover3<=1;
				    lgs3<=1;
				end										
		end
	else if(ly3<=30+10)        ///shang banzi
		begin 
			if(lx_boardu3-55<=lx3 && lx3<=lx_boardu3+55)		//zhuang dao ban zi shang
				begin
					ly_dir3 <= 1;
					lx_dir3 <= lx_dir3;
				end
			else
				begin
					lover3<=1;
					lgs3<=2;
				end										
		end	
	else if (lx3<=20)		//zhuang zuo xian
		lx_dir3 <=1;

	else if (lx3>=518)		//zhuang you xian
		lx_dir3<= 0;

end	

always @(posedge clk or posedge reset )
begin
	if (reset)
		ly3 <= 400; 
    else
		begin
			if(lover3==0)	
				begin
				    if(ly_dir3)
						ly3 <=ly3+1;
					else
						ly3<=ly3-1;
				end	
			else
				begin
					ly3<=ly3;
				end		
		end		
end	


always @(posedge clk or posedge reset )
begin
	if (reset)
		lx3 <= 400; 
    else
		begin
			if(lover3==0)	
				begin
				    if(lx_dir3)
						lx3 <=lx3+1;
					else
						lx3<=lx3-1;
				end	
			else
				begin
					lx3<=lx3;
				end		
		end		
end

always @(hortional_counter or vertiacl_counter )
begin
     LD=((hortional_counter-lx3)*(hortional_counter-lx3)+(vertiacl_counter-ly3)*(vertiacl_counter-ly3));
		if(lgs3==1)
			begin
				if(((145<=hortional_counter && hortional_counter <=205)||(275<=hortional_counter && hortional_counter <=335))&&((200<=vertiacl_counter && vertiacl_counter <= 210)))
				    RGB2= 3'b000;  // draw wu nai
				else if((210<=hortional_counter && hortional_counter <=270)&&((290<=vertiacl_counter && vertiacl_counter <= 300)))
				    RGB2= 3'b000;  // draw wu nai 
				else if((365<=hortional_counter && hortional_counter <=370)&&((190<=vertiacl_counter && vertiacl_counter <= 210)))
				    RGB2= 3'b000;  // draw wu nai 
				else if((380<=hortional_counter && hortional_counter <=385)&&((180<=vertiacl_counter && vertiacl_counter <= 220)))
				    RGB2= 3'b000;  // draw wu nai         
				else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
						
						RGB2= 3'b010;  // draw bian kuang
				else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
						RGB2= 3'b011;  // draw bian kuang
				else if(11<=hortional_counter && hortional_counter <= 529
								  && 11<=vertiacl_counter && vertiacl_counter <= 469 )
						RGB2 = 3'b111;	
				else
					begin
						RGB2=3'b000;//others-black
					end			
            end
        else if(lgs3==2)
			begin
				if((((hortional_counter-265)*(hortional_counter-265)+(vertiacl_counter-250)*(vertiacl_counter-250))<=75*75)&&
		         vertiacl_counter>=290)
		         RGB2=color1;                     //laugh face
				else if(((hortional_counter-225)*(hortional_counter-225)+(vertiacl_counter-210)*(vertiacl_counter-210))<=100)
				 RGB2=color1;	                 //laugh face
				else if(((hortional_counter-305)*(hortional_counter-305)+(vertiacl_counter-210)*(vertiacl_counter-210))<=100)
				 RGB2=color1;
				
				else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
						
						RGB2= 3'b010;  // draw bian kuang
				else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
						RGB2= 3'b011;  // draw bian kuang
				else if(11<=hortional_counter && hortional_counter <= 529
								  && 0<=vertiacl_counter && vertiacl_counter <= 469 )
						RGB2 = 3'b111;	
				 else
					begin
						RGB2=3'b000;//others-black
					end			
            end

				
		
		else
			 begin
				 if(LD<=100) 
					RGB2=3'b110;//ball
				 else if (lx_boardu3-55<=hortional_counter && hortional_counter <= lx_boardu3+55 &&
						11<=vertiacl_counter && vertiacl_counter <= 31)
					RGB2=3'b100;//shangboard
				 else if (lx_boardd3-55<=hortional_counter && hortional_counter <= lx_boardd3+55 &&
						ly_boardd3<=vertiacl_counter && vertiacl_counter <= 468)
					RGB2=3'b001;//xiaboard
				 else if((0<=hortional_counter && hortional_counter <=539)&&((0<=vertiacl_counter && vertiacl_counter <= 10)||(469<=vertiacl_counter && vertiacl_counter <=479 )))
						
						RGB2= 3'b010;  // draw bian kuang
				 else if((0<=vertiacl_counter && vertiacl_counter <= 479)&&((0<=hortional_counter && hortional_counter <=10 )||(529<=hortional_counter && hortional_counter <=539 )))
						RGB2= 3'b011;  // draw bian kuang
				 else if(11<=hortional_counter && hortional_counter <= 529
							   && 11<=vertiacl_counter && vertiacl_counter <=239  )
						RGB2 = 3'b101;              ////DRAW background
					   
				 else if(11<=hortional_counter && hortional_counter <= 529
								  && 241<=vertiacl_counter && vertiacl_counter <= 469 )
						RGB2 = 3'b111;
				 else
					begin
						RGB2=3'b000;//others-black
					end
			end		
end   	
	
	
	
endmodule











