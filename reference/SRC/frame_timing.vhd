library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity frame_time is
port
(
  nreset         : in std_logic;
  clk25          : in std_logic;
  --#
  start_frame    : in std_logic;
  --#lcd
  lcd_clk        : out std_logic;
  lcd_disp      : out std_logic;  --#led-displayon/off + enable led-backlightdriver(1=on)
  lcd_dim     : inout std_logic;
  --
  lcd_vsync          : out std_logic;
  lcd_hsync          : out std_logic;
  lcd_dval       : inout std_logic;
  --#lcd-data:
  lcdr           : out std_logic_vector(7 downto 0); --# := x"00";
  lcdg           : out std_logic_vector(7 downto 0); --# := x"00";
  lcdb           : out std_logic_vector(7 downto 0); --# := x"00";

  run_line_deb   : out std_logic;
  vline_cnt0_deb : out std_logic
);
end frame_time;


architecture frame_time_arch of frame_time is


constant vspw       : unsigned(11 downto 0) := x"003";  
constant vbp        : unsigned(11 downto 0) := x"020"; 
constant vbpda      : unsigned(11 downto 0) := x"200";  
constant vbpdafp    : unsigned(11 downto 0) := x"20d"; 
constant hspw       : unsigned(11 downto 0) := x"019";  
constant hbp        : unsigned(11 downto 0) := x"058";  
constant hbpda      : unsigned(11 downto 0) := x"378";  
constant hbpdafp    : unsigned(11 downto 0) := x"3a0";  


signal s_vert_cnt    : unsigned(11 downto 0); 
signal s_vdval       : std_logic; 
signal s_dval        : std_logic; 

--#horizontal:
signal htime_cnt    : unsigned(11 downto 0) := x"000";  --#horizontal: time/clk-cnt

--#lcd-data:
signal dot_cnt      : unsigned(11 downto 0) := x"000";

--#lcd-dimm/pwm:
signal lcd_dimm_cnt : unsigned(11 downto 0) := x"000";

begin
  lcd_clk  <= clk25;
  lcd_disp <= '1'; --#lcd-disp:1=on
  
--debug:
run_line_deb   <= run_line;
vline_cnt0_deb <= s_vert_cnt(0);


  --#lcd-display (typ:nhd-7.0-800480ef-atxl#-ctp):
  --#frame-timing:
  process(nreset,clk25) is
  begin  
    if(nreset='0')then
      s_vert_cnt <= (others =>'0');
      htime_cnt <= (others =>'0');
      --#
      lcd_vsync <= '1'; 
      vdval     <= '0';
      run_line  <= '0';
      --#
      lcd_hsync <= '1';
      lcd_dval  <= '0';
      
    elsif rising_edge(clk25)then
    
      --#vertical:
      lcd_vsync <= '1';
      vdval     <= '0';
      --run_line <= '0';
      
      if((start_frame='1') or (run_line='1'))then
        run_line <='1';
        
        if(s_vert_cnt < vspw)then
          lcd_vsync <= '0';
        end if;
        
        if(s_vert_cnt >= vbp and s_vert_cnt <= vbpda)then
           vdval <= '1';
        end if;
        
        if(s_vert_cnt >= vbpdafp)then
          run_line <='0';
          s_vert_cnt <= (others =>'0');
        end if;
                
      end if;
            
      
      ------------------------------
      --#horizontal:
      -----------------------------
      --#default
      lcd_hsync <= '1';
      lcd_dval  <= '0';

      if(run_line='1')then
        htime_cnt <= htime_cnt + 1;
        
        --#horz-sync:
        if(htime_cnt < hspw)then
          lcd_hsync <= '0';
        end if;
    
        --#data-enable:
        if(vdval='1' and (htime_cnt>= hbp and htime_cnt < hbpda))then
          lcd_dval <= '1';
        end if;

        --#line-end
        if(htime_cnt>= hbpdafp)then
          htime_cnt <= (others =>'0');
          --#
          s_vert_cnt <= s_vert_cnt + 1;
        end if;
        
      end if; 
      
    end if;
  end process;          

  --#frame-data:
  process(nreset,clk25) is
  begin  
    if(nreset='0')then
      dot_cnt <= (others =>'0');
      --#
      lcdr <= (others =>'0');
      lcdg <= (others =>'0');
      lcdb <= (others =>'0');
            
    elsif rising_edge(clk25)then

      lcdr <= (others =>'0');
      lcdg <= (others =>'0');
      lcdb <= (others =>'0');
    
    --if(htime_cnt>= hbp and htime_cnt < hbpda))then 
    if(s_vert_cnt < vbp+x"0f0")then --#1.halfpicture (vpb+240-lines)
      if(lcd_dval='1')then
        dot_cnt <= dot_cnt + 1;
      
        if((dot_cnt>=x"000") and(dot_cnt< x"064"))then      --#0...100
          lcdr<=x"cf";
        elsif((dot_cnt>=x"064") and(dot_cnt< x"0c8"))then  --#100...200
           lcdg<=x"cf";
        elsif((dot_cnt>=x"0c8") and(dot_cnt< x"12c"))then  --#200...300
          lcdb<=x"cf";
        elsif((dot_cnt>=x"12c") and(dot_cnt< x"190"))then  --#300...400
          lcdr<=x"cf";
          lcdg<=x"cf";
        elsif((dot_cnt>=x"190") and(dot_cnt< x"1f4"))then  --#400...500
          lcdr<=x"cf";
          lcdb<=x"cf";
        elsif((dot_cnt>=x"1f4") and(dot_cnt< x"258"))then  --#500...600
          lcdr<=x"cf";
          lcdg<=x"cf";
          lcdb<=x"cf";
        elsif((dot_cnt>=x"258") and(dot_cnt< x"2bc"))then  --#600...700
          lcdr<=x"9f";
          lcdg<=x"cf";
          lcdb<=x"6f";          
        elsif((dot_cnt>=x"2bc"))then -- and(dot_cnt< x"2bc"))then  --#600...700
          lcdr<=x"6f";
          lcdg<=x"cf";
          lcdb<=x"9f";          
        else
          lcdr<= (others =>'0');
        end if;     

      else
        dot_cnt <= (others =>'0');
      end if;
    
          
    elsif(s_vert_cnt < vbp+x"12c")then  --#5/8-picture (240..300-lines)
    
      if(lcd_dval='1')then
        dot_cnt <= dot_cnt + 1;
        --
        lcdr <= std_logic_vector(dot_cnt(7 downto 0));
        --lcdg <= std_logic_vector(x"ff" - dot_cnt(7 downto 0));
      else
        dot_cnt <= (others =>'0');
      end if;
      
    elsif(s_vert_cnt < vbp+x"168")then  --#6/8-quarter-picture (300..360-lines)
    
      if(lcd_dval='1')then
        dot_cnt <= dot_cnt + 1;
        --
        lcdg <= std_logic_vector(dot_cnt(7 downto 0));
      else
        dot_cnt <= (others =>'0');
      end if;

    elsif(s_vert_cnt < vbp+x"1a4")then  --#7/8-picture (360..420-lines)

      if(lcd_dval='1')then
        dot_cnt <= dot_cnt + 1;
        --
        lcdb <= std_logic_vector(dot_cnt(7 downto 0));
      else
        dot_cnt <= (others =>'0');
      end if;
    
    else                    --#8/8-picture(360...480-lines) 
      if(lcd_dval='1')then
        dot_cnt <= dot_cnt + 1;
        --
        lcdr <= std_logic_vector(dot_cnt(7 downto 0));
        lcdg <= std_logic_vector(x"ff" - dot_cnt(7 downto 0));
        lcdb <= std_logic_vector(x"80" + dot_cnt(7 downto 1) );
      else
        dot_cnt <= (others =>'0');
      end if; 
    end if;   
    
    end if;
  end process;
  
  
  
  --###lcd-dimm/pwm
  process(nreset,clk25) is
  begin  
    if(nreset='0')then
      lcd_dimm_cnt <= (others =>'0');
      lcd_dim      <= '0';
    elsif rising_edge(clk25)then
      if(lcd_dimm_cnt=x"3e8")then     --#x"3e8"=1000 =>25khz
        lcd_dimm_cnt <= (others =>'0');
        lcd_dim      <= not lcd_dim;    --#12.5khz
      else
        lcd_dimm_cnt <= lcd_dimm_cnt + 1;
        lcd_dim      <= lcd_dim;
      end if;
    end if;
  end process;

end frame_time_arch;
