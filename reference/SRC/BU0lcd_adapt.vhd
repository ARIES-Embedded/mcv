library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity lcd_adapt is
port
(
	vid_rst_n : in std_logic;
	vid_clk   : in std_logic;

	vid_dat  : in std_logic_vector(23 downto 0);
   vid_val  : in std_logic;
   vid_rdy  : out std_logic;	
	
	lcd_clk        : out std_logic;
	lcd_disp			: out std_logic;  -- led-displayon/off + enable led-backlightdriver(1=on)
	lcd_dim			: out std_logic;
	lcd_vsync      : out std_logic;
	lcd_hsync      : out std_logic;
	lcd_dval       : out std_logic;
	lcd_red        : out std_logic_vector(7 downto 0);
	lcd_green      : out std_logic_vector(7 downto 0);
	lcd_blue       : out std_logic_vector(7 downto 0)
);
end lcd_adapt;


architecture rtl of lcd_adapt is


begin

	-- Horst: 25ms (t-frame=~20ms)
	pll_rst <= not vid_rst_n;


end rtl;
