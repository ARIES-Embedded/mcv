library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity fpga_appli is
generic (g_test: boolean := false );
port
(
  rst_n            : in std_logic;
  fpga_refclk      : in std_logic;
  fpga_clk         : out std_logic;
  fpga_clk_rst_n   : out std_logic;
  
  vid_pkgstrt : in std_logic;
  vid_pkgend  : in std_logic;
  vid_dat     : in std_logic_vector(23 downto 0);
  vid_val     : in std_logic;
  vid_rdy     : out std_logic; 
  
  lcd_clk        : out std_logic;
  lcd_disp       : out std_logic;
  lcd_dim        : out std_logic;
  lcd_vsync      : out std_logic;
  lcd_hsync      : out std_logic;
  lcd_dval       : out std_logic;
  lcd_red        : out std_logic_vector(7 downto 0);
  lcd_green      : out std_logic_vector(7 downto 0);
  lcd_blue       : out std_logic_vector(7 downto 0);

  led  : out std_logic_vector(5 downto 0)
);
end fpga_appli;


architecture rtl of fpga_appli is

component appli_pll is
port(
  refclk   : in  std_logic := '0';
  rst      : in  std_logic := '0';
  outclk_0 : out std_logic; 
  outclk_1 : out std_logic; 
  outclk_2 : out std_logic;
  locked   : out std_logic 
);
end component appli_pll;

component ressync is
generic
(
  rst_num: integer := 1;
  ipol: integer := integer'high;
  opol: std_logic := '0' 
);
port
(
  clk: in std_logic;
  rst: in std_logic_vector(rst_num-1 downto 0);
  clk_rst: out std_logic 
);
end component;

component lcd_adapt is
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
end component lcd_adapt;

signal s_pll_rst        : std_logic;
signal s_led_clk        : std_logic;
signal s_fpga_clk       : std_logic;
signal s_fpga_clk_rst_n : std_logic;
signal s_lcd_clk        : std_logic;
signal s_lcd_hsync      : std_logic;
signal s_lcd_vsync      : std_logic;
signal s_fpga_clk_locked: std_logic;
signal s_vid_pkgstrt    : std_logic;
signal s_vid_rdy        : std_logic;
signal s_vid_dat        : std_logic_vector(23 downto 0);
signal s_vid_val        : std_logic;
signal s_resc_pkgstrt   : std_logic;
signal s_resc_rdy       : std_logic;
signal s_resc_dat       : std_logic_vector(23 downto 0);
signal s_resc_val       : std_logic;

signal s_resc_typ       : std_logic;
signal s_vid_typ        : std_logic;
signal vid_typ          : std_logic;



begin

  s_pll_rst <= not rst_n;
  fpga_clk <= s_fpga_clk;
  fpga_clk_rst_n <= s_fpga_clk_rst_n;
  lcd_clk <= s_lcd_clk;  -- minor todo: yet unused

  pll_inst : appli_pll
  port map
  (
    refclk   => fpga_refclk,  
    rst      => s_pll_rst,  -- high-active
    outclk_0 => s_fpga_clk, -- 50Mhz
    outclk_1 => s_lcd_clk,  -- 25Mhz
    outclk_2 => s_led_clk,  -- 1Mhz   
    locked   => s_fpga_clk_locked
  );

  ressync_inst: ressync
  generic map
  (
    rst_num => 2,
    ipol    => 0,
    opol    => '0'
  )
  port map
  (
    clk    => s_fpga_clk,
    rst(0) => rst_n,
    rst(1) => s_fpga_clk_locked,
    clk_rst=> s_fpga_clk_rst_n
  );

  test_gen: if g_test generate
    imggen_inst: entity work.img_gen
    port map (
      clk_rst_n=>s_fpga_clk_rst_n,
      clk=>s_fpga_clk,
      vid_dat=>s_vid_dat,
      vid_val=>s_vid_val,
      vid_pkgstrt=>open,
      vid_pkgend=>open,
      vid_rdy=>s_vid_rdy
    );
    vid_rdy <= '1';
	 vid_typ <= '1';
	 s_vid_pkgstrt <= '0'; 
	 
  end generate test_gen;

  fb_gen: if not g_test generate
   
    -- avalon streaming adaption	 
	 avln_adpt_prc: process(s_fpga_clk, s_fpga_clk_rst_n) is
    begin
      if s_fpga_clk_rst_n='0' then
		  s_resc_dat <= (others=>'0');
		  s_resc_val <= '0';
		  s_resc_pkgstrt <= '0';
		  s_resc_typ <= '0'; 
        vid_typ <= '0';		  
		elsif rising_edge(s_fpga_clk) then
		  s_resc_val <= (vid_val or s_resc_val) and not s_vid_rdy;
		  if (not s_resc_val or s_vid_rdy)='1' then
		    s_resc_dat <= vid_dat;
		    s_resc_pkgstrt <= vid_pkgstrt;
			 s_resc_typ <= vid_typ;
		  end if;
		  if (vid_pkgstrt and vid_val)='1' then
		    if vid_dat(3 downto 0)="0000" then
		      vid_typ <= '1';
			 else
			   vid_typ <= '0';
			 end if;
		  end if;
		end if;
    end process;
    vid_rdy <= s_vid_rdy;
	 s_vid_val <= s_resc_val or vid_val; 
	 s_vid_dat <= s_resc_dat when s_resc_val='1' else
	              vid_dat;
	 s_vid_typ <= s_resc_typ when s_resc_val='1' else
	              vid_typ;
	 s_vid_pkgstrt <= s_resc_pkgstrt when s_resc_val='1' else
	              vid_pkgstrt;
	 
  end generate fb_gen;


  adapt_inst: lcd_adapt
  port map
  (
    vid_clk_rst_n => s_fpga_clk_rst_n,
    vid_clk       => s_fpga_clk,
    vid_pkgstrt   => s_vid_pkgstrt,
	 vid_typ       => s_vid_typ,
    vid_dat       => s_vid_dat,
    vid_val       => s_vid_val,
    vid_rdy       => s_vid_rdy,   
    lcd_clk    => s_lcd_clk,
    lcd_disp   => lcd_disp,
    lcd_dim    => lcd_dim,
    lcd_vsync  => s_lcd_vsync,
    lcd_hsync  => s_lcd_hsync,
    lcd_dval   => lcd_dval, 
    lcd_red    => lcd_red, 
    lcd_green  => lcd_green, 
    lcd_blue   => lcd_blue      
  );
  
  -- debug
  lcd_hsync <= s_lcd_hsync;
  lcd_vsync <= s_lcd_vsync;
  led(0) <=  s_lcd_vsync;
  led(1) <= s_lcd_hsync;
  led(5 downto 2) <= (others=>'0');

end rtl;
