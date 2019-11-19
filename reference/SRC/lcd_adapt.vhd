library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pkg_lcd.all;
 
entity lcd_adapt is
port
(
  vid_clk_rst_n : in std_logic;
  vid_clk       : in std_logic;

  vid_pkgstrt: in std_logic;
  vid_typ    : in std_logic;
  vid_dat    : in std_logic_vector(23 downto 0);
  vid_val    : in std_logic;
  vid_rdy    : out std_logic; 
  
  lcd_clk        : in std_logic;
  lcd_disp       : out std_logic; 
  lcd_dim        : out std_logic;
  lcd_vsync      : out std_logic;
  lcd_hsync      : out std_logic;
  lcd_dval       : out std_logic;
  lcd_red        : out std_logic_vector(7 downto 0);
  lcd_green      : out std_logic_vector(7 downto 0);
  lcd_blue       : out std_logic_vector(7 downto 0)
);
end lcd_adapt;

architecture rtl of lcd_adapt is

  signal s_horiz_cnt   : unsigned(11 downto 0); 
  signal s_vert_cnt    : unsigned(11 downto 0); 
  signal s_vdval       : std_logic; 
  signal s_dval        : std_logic; 
  signal s_lcd_dval_del: std_logic;
  signal s_lcd_dval    : std_logic; 
  signal s_vsync       : std_logic;
  signal s_hsync       : std_logic;
  signal s_resync      : std_logic;
  signal s_vid_pkgstrt : std_logic;
  signal s_vid_dat     : std_logic_vector(23 downto 0);
  signal s_vid_val     : std_logic;
  signal s_vid_rdy     : std_logic;
  signal vid_pix       : std_logic;
  
  signal s_prev_vid_pkgstrt: std_logic;   
  signal s_vid_not_in_time : std_logic;  -- debug
  signal s_finished        : std_logic;

  -- for dimming pwm signal 
  signal s_dim_cnt : unsigned(11 downto 0);
  signal s_lcd_dim : std_logic;

begin

  -- to be inserted because the IP interface needs ready when data invalid to start  
  entry_prc: process(vid_clk_rst_n, vid_clk) is
  begin
    if vid_clk_rst_n='0' then
      s_vid_val <= '0';
		s_vid_dat <= (others=>'0');
		s_vid_pkgstrt <= '0';
		s_prev_vid_pkgstrt <= '0';
    elsif rising_edge(vid_clk) then
	   if (vid_val and vid_pkgstrt)='1' then
		  s_prev_vid_pkgstrt <= '1';
		end if; 
      if (vid_pix and (not s_vid_val or s_vid_rdy))='1' then
		  s_vid_dat <= vid_dat;
		  s_vid_pkgstrt <= s_prev_vid_pkgstrt;
		  s_prev_vid_pkgstrt <= '0';
	   end if;
      s_vid_val <= vid_pix or (s_vid_val and not s_vid_rdy); 		
    end if;
  end process;
  vid_rdy <= not s_vid_val or s_vid_rdy;
  vid_pix <= vid_val and not vid_pkgstrt and vid_typ;
  
  vid_ack_prc: process(vid_clk_rst_n, vid_clk) is
  begin
    if vid_clk_rst_n='0' then
      s_lcd_dval_del <= '0';
    elsif rising_edge(vid_clk) then
      if s_lcd_dval='1' then
        s_lcd_dval_del <= not s_lcd_dval_del;
      else
        s_lcd_dval_del <= '0';
      end if;
    end if;
  end process;
  s_vid_rdy <= s_lcd_dval and not s_lcd_dval_del;

  lcd_disp <= '1'; -- 1=on
  
  s_resync <= s_vid_val and s_vid_pkgstrt and not s_finished;
  
  
  lcd_stream_prc: process(vid_clk_rst_n, lcd_clk) is
  begin  
  
    if vid_clk_rst_n='0' then
      s_vert_cnt <= c_tv;
      s_horiz_cnt <= c_th;
      s_vsync <= '1'; 
      s_hsync <= '1';
      lcd_red <= (others=>'0');
      lcd_green <= (others=>'0');
      lcd_blue <= (others=>'0');
      s_vdval <= '0';
      s_dval  <= '0';
      s_finished <= '1'; 
      s_vid_not_in_time <= '0';		
    elsif rising_edge(lcd_clk)then

      if s_horiz_cnt=c_th then
        s_hsync <= '0';
        s_horiz_cnt <= (others=>'0');
        if s_vert_cnt=c_tv then
          s_vsync <= '0';
          s_vert_cnt <= (others=>'0');
        else
          s_vert_cnt <= s_vert_cnt + 1;
        end if;
        if s_vert_cnt=c_vspw then
          s_vsync <= '1';
        end if;
        if s_vert_cnt=c_tvb then
          s_vdval <= '1';
        end if;
        if s_vert_cnt=c_tvbda then
          s_vdval <= '0';
			 s_finished <= '1';
        end if;        
      else
         s_horiz_cnt <= s_horiz_cnt+1;
      end if;   

      if s_horiz_cnt=c_hspw then
        s_hsync <= '1';
      end if;
      if s_vdval='1' and s_horiz_cnt=c_thb then
        s_dval <= '1';
      end if;
      if s_horiz_cnt=c_thbda then
        s_dval <= '0';
      end if;        

		s_vid_not_in_time <= '0';
      if (s_dval and s_vid_val)='1' then
        lcd_red <= s_vid_dat(23 downto 16);
        lcd_green <= s_vid_dat(15 downto 8);
        lcd_blue <= s_vid_dat(7 downto 0);
      elsif (s_dval and not s_vid_val)='1' then -- just for debug
		  s_vid_not_in_time <= '1';
        lcd_red <= (others=>'1');
        lcd_green <= (others=>'1');
        lcd_blue <= (others=>'1');
		else
        lcd_red <= (others=>s_vid_not_in_time);
        lcd_green <= (others=>s_vid_not_in_time);
        lcd_blue <= (others=>s_vid_not_in_time);
      end if;
 
      -- resync
      if s_resync='1' then
        s_vert_cnt <= c_tvb+1;
        s_hsync <= '1';
        s_vsync <= '1'; 
        if s_horiz_cnt>(c_thb+1) then
          s_horiz_cnt <= c_thb+1;
          s_dval <= '1';
        end if;
        
      end if;

      lcd_hsync <= s_hsync;
      lcd_vsync <= s_vsync;
      s_lcd_dval <= s_dval;
		
		if s_lcd_dval='1' then
		  s_finished <= '0';
		end if;
		
    end if;

  end process;          
  lcd_dval <= s_lcd_dval;
 
  dim_prc: process(vid_clk_rst_n, vid_clk) is
  begin  
    if vid_clk_rst_n='0' then
      s_dim_cnt <= (others =>'0');
      s_lcd_dim <= '0';
    elsif rising_edge(vid_clk)then
      if s_dim_cnt=x"3e8" then  -- =1000 =>25khz
        s_dim_cnt <= (others =>'0');
        s_lcd_dim <= not s_lcd_dim;  -- 12.5khz
      else
        s_dim_cnt <= s_dim_cnt + 1;
      end if;
    end if;
  end process;
  lcd_dim <= s_lcd_dim;

  
end rtl;
