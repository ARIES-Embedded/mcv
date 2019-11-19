library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity led_output is
port
(
	clk_rst_n : in std_logic;
	clk       : in std_logic;
	led       : out std_logic_vector(4 downto 0)
);
end led_output;


architecture rtl of led_output is

signal div_clk0 : std_logic;
signal div_clk1 : std_logic;

signal cnt0 : unsigned(9 downto 0) := (others =>'0');
signal cnt1 : unsigned(9 downto 0) := (others =>'0');
signal cnt2 : unsigned(2 downto 0) := (others =>'0');


begin

	--#divide clk to 500hz 
	process(clk_rst_n,clk) is
	begin  
		if(clk_rst_n='0')then
			cnt0 <= (others =>'0');
			div_clk0 <= '0';
		elsif rising_edge(clk)then
			if(cnt0=1000)then
				cnt0 <= (others =>'0');
				div_clk0 <= not div_clk0;  --#500hz
			else
				cnt0 <= cnt0 + 1;
				div_clk0 <= div_clk0;
			end if;
		end if;
	end process;


	process(clk_rst_n,div_clk0) is
	begin  
		if(clk_rst_n='0')then
			cnt1 <= (others =>'0');
			div_clk1 <= '0';
		elsif rising_edge(div_clk0)then
			if(cnt1=125)then
				cnt1 <= (others =>'0');			
				div_clk1 <= not div_clk1;  --#~2hz
			else
				cnt1 <= cnt1 + 1;
				div_clk1 <= div_clk1;
			end if;
		end if;
	end process;

	
	process(clk_rst_n,div_clk1) is
	begin  
		if(clk_rst_n='0')then
			cnt2 <= (others =>'0');
			led <= (others=>'0');
		elsif rising_edge(div_clk1)then
			
			if(cnt2=8)then
				cnt2 <= (others =>'0');
			else
				cnt2 <= cnt2 + 1;
			end if;

			case cnt2 is
				when "000" => led(0) <= '0'; led2 <= '0'; led4 <= '0'; led5 <= '0'; led6 <= '0';

				when "001" => led(0) <= '0'; led2 <= '0'; led4 <= '0'; led5 <= '0'; led6 <= '1';
				
				when "010" => led(0) <= '0'; led2 <= '0'; led4 <= '0'; led5 <= '1'; led6 <= '0';
				
				when "011" => led(0) <= '0'; led2 <= '0'; led4 <= '0'; led5 <= '1'; led6 <= '1';
				
				when "100" => led(0) <= '0'; led2 <= '0'; led4 <= '1'; led5 <= '0'; led6 <= '0';
				
				when "101" => led(0) <= '0'; led2 <= '0'; led4 <= '1'; led5 <= '0'; led6 <= '1';

				when "110" => led(0) <= '0'; led2 <= '0'; led4 <= '1'; led5 <= '1'; led6 <= '0';
				
				when "111" => led(0) <= '1'; led2 <= '1'; led4 <= '1'; led5 <= '1'; led6 <= '1';
			end case;
			
		end if;
	end process;

end led_output;
