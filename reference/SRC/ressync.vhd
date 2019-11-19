
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;


entity ressync is
  generic
   (
    rst_num: integer := 1;
    ipol: integer := integer'high;  -- input reset polarity for each reset, 1: high active
    opol: std_logic := '0'  -- output reset polarity, 1: high active
   );
  port
   (
    clk: in std_logic;
    rst: in std_logic_vector(rst_num-1 downto 0);
    clk_rst: out std_logic  -- deassertion synced reset
   );
end ressync;


architecture rtl of ressync is

  signal s_rst_n: std_logic_vector(rst_num-1 downto 0); -- low active input resets
  constant c_polarities: std_logic_vector(rst_num-1 downto 0) := std_logic_vector(to_unsigned(ipol, rst_num));

begin

  sync_gen: for i in rst'range generate

    sft_prc: process( clk, rst(i))
      variable v_rst_n: std_logic_vector(2 downto 0);
    begin
      if rst(i)=c_polarities(i) then
        v_rst_n := (others=>'0');
        s_rst_n(i) <= '0';
      elsif rising_edge(clk) then
        v_rst_n := v_rst_n(1 downto 0)&'1';
        s_rst_n(i) <= v_rst_n(v_rst_n'high);
      end if;
    end process;

  end generate;

  clk_rst <= opol when and_reduce(s_rst_n)='0' else 
             not opol;

end rtl;

