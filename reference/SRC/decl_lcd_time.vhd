-- Project    : mcv frame buffer
-- Function   : package for lcd display constants
-- Note       : Language : VHDL-2008
-- ----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package pkg_lcd is

  -- --------------------------------------------------------------------------------------------------
  -- timing constants for 800x480 TFT display (as NHD-7.0-800480EF-ATXL#-CTP ):
  --     horizontal line = horz.bporch+disparea+fporch = 88+800+40 = 928 = x3a0 [dclk]
  --     vs period time = vert.bporch+disparea+fporch = 32+480+139 = 525 = x20d [th]
  --     vsync pulse-width = 3 [th] = typical
  --     hsync pulse width = 25 = x19 [dclk], typical: 40
  --     horz.bporch = 88 = x58 [dclk]
  --     vert.bporch = 32 = x20 [th]
  --     horiz.disparea = 800 [dclk]
  --     vert.disparea = 480 [th]
   
  constant c_th    : unsigned(11 downto 0) := x"39E"-1; -- 926, horizontal line-1
  constant c_tv    : unsigned(11 downto 0) := x"21C"-1; -- 540, vs period time-1

  constant c_hspw  : unsigned(11 downto 0) := x"019"-1;  -- hsync pulse width-1
  constant c_vspw  : unsigned(11 downto 0) := x"003"-1;  -- vsync pulse width-1
  
  constant c_thb   : unsigned(11 downto 0) := x"058"-1; -- horizonal bporch-1 
  constant c_tvb   : unsigned(11 downto 0) := x"020"-1; -- vertical bporch-1

  constant c_thd   : unsigned(11 downto 0) := x"320";  -- horiz.disparea = 800 
  constant c_tvd   : unsigned(11 downto 0) := x"1E0";  -- vert-disparea= 480

  constant c_tvbda : unsigned(11 downto 0) := c_tvb+c_tvd;  -- vert.bporch+disparea  = 512
  constant c_thbda : unsigned(11 downto 0) := c_thb+c_thd;  -- horz.bporch+disparea  = 888 = x378

  -- --------------------------------------------------------------------------------------------------

  constant c_pix_width: integer := 24;

end package pkg_lcd;
