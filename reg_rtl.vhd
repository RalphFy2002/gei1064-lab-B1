library ieee;
use ieee.std_logic_1164.all;

entity reg_rtl is
  generic (N : integer :=8);
  port(	i_r: in std_logic_vector(N-1 downto 0);
	    reset,clk: in std_logic;
	    out_r: out std_logic_vector(N-1 downto 0)
      );
end reg_rtl;  

architecture registre of reg_rtl is
signal out_r_temp : std_logic_vector(N-1 downto 0);
begin 
    process(reset,clk)
    begin
        if reset='1' then 
           out_r_temp <= (others =>'0');
        elsif clk'event and clk='1' then
            out_r_temp <= i_r;
        end if;
    end process;
    out_r <= out_r_temp;      
end registre;