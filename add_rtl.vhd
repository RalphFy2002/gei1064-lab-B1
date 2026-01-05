library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;  
 
entity add_rtl is
  generic (M : integer :=16);
  port (i_a, i_b     : in std_logic_vector(M-1 downto 0);
        reset         : in  std_logic;
        out_s       : out std_logic_vector(M-1 downto 0)
       );
end add_rtl; 
 
architecture addition of add_rtl is
          
begin
 
  c_sum : process (i_a, i_b,reset)
  variable s_temp : std_logic_vector(M-1 downto 0);
  begin
  s_temp := i_a + i_b;
  
  if reset = '1' then
       s_temp := (others =>'0');
  
  elsif s_temp(M-1) = '0' and i_a(M-1) = '1' and i_b(M-1) = '1' then             
      s_temp := (others => '0');
      s_temp(M-1) := '1';
	  
  elsif s_temp(M-1) = '1' and i_a(M-1) = '0' and i_b(M-1) = '0' then 
      s_temp := (others => '1');
      s_temp(M-1) := '0';
     
  end if;
  
  out_s <=  s_temp;
       
  end process c_sum;
  
end addition;
