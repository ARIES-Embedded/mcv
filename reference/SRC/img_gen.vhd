-- Author     : 
-- Project    : generic
-- Function   : gen a simple test pattern image
-- Note       : Language : VHDL-2008
-- ----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.pkg_lcd.all;


entity img_gen is
  generic (
    g_tc: integer := 0
  );
  port (
    clk: in std_logic;
    clk_rst_n: in std_logic;
    vid_dat: out std_logic_vector(c_pix_width-1 downto 0);
    vid_val: out std_logic;
    vid_pkgstrt: out std_logic;
    vid_pkgend: out std_logic;
    vid_rdy: in std_logic
  );
end entity img_gen;


architecture rtl of img_gen is

  function gen_pix(pix: integer; ln: integer) return std_logic_vector is
    variable v_8pix: integer range 0 to 255;
    variable v_8ln: integer range 0 to 3;
    variable v_data: std_logic_vector(c_pix_width-1 downto 0); 
  begin
    v_8pix := (pix/8) mod 256;
    v_8ln := (ln/8)  mod 4;
    v_data := (others=>'0');
    case v_8ln is 
      when 0 =>
        v_data(7 downto 0) := std_logic_vector(to_unsigned(v_8pix,8));
      when 1 =>
        v_data(15 downto 8) := std_logic_vector(to_unsigned(v_8pix,8));
      when 2 =>
        v_data(23 downto 16) := std_logic_vector(to_unsigned(v_8pix,8));
      when others =>
        v_data := std_logic_vector(to_unsigned(v_8pix,8))
                 &std_logic_vector(to_unsigned(v_8pix,8))
                 &std_logic_vector(to_unsigned(v_8pix,8));
    end case;
    return v_data;    
  end function;

  constant c_max: integer := 2*to_integer(c_th+1)*to_integer(c_tv+1)-1;
  signal frmtrg: boolean;
  signal s_vid_val: std_logic;
  signal cnt: integer range 0 to c_max;
  signal pix: integer range 0 to to_integer(c_th);
  signal ln: integer range 0 to to_integer(c_tv);

begin
 
  process(clk, clk_rst_n) is
  begin
    if clk_rst_n='0' then
      cnt <= 0;
      frmtrg <= false;
    elsif rising_edge(clk) then
      if cnt=c_max then
        cnt <= 0;
        frmtrg <= true;
      else
        cnt <= cnt+1;
        if s_vid_val='1' then
          frmtrg <= false;
        end if;
      end if; 
    end if;
  end process;

  wait4rd_prc: process(clk, clk_rst_n)
  begin
    if clk_rst_n='0' then
      vid_dat <= (others=>'0'); 
      s_vid_val <= '0';
      vid_pkgstrt <= '0';
      vid_pkgend <= '0';
      ln <= 0;
      pix <= 0;      
    elsif rising_edge(clk) then 
      if ln>0 or pix>0 or frmtrg then
        if (not s_vid_val or vid_rdy)='1' then      
          vid_dat <= gen_pix(pix, ln); 
          s_vid_val<='1';
          vid_pkgstrt <= '0';
          vid_pkgend <= '0';
          if pix=0 and ln=0 then
            vid_pkgstrt<='1';
          elsif pix=to_integer(c_thd-1) and ln=to_integer(c_tvd-1) then
            vid_pkgend <= '1';
          end if;
          if pix=(c_thd-1) then
            pix <= 0;
            if ln=to_integer(c_tvd-1) then
              ln <= 0;
            else
              ln <= ln+1;
            end if;
          else
            pix <= pix+1;
          end if;
        end if;
      else
        s_vid_val <= s_vid_val and not vid_rdy;
      end if;
    end if;  
  end process;
  vid_val <= s_vid_val;

end architecture rtl;
