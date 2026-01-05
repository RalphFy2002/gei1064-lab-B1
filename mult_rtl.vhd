library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;  

entity mult_rtl is
  generic (N : integer :=8);
  port ( i_a,i_b : in  std_logic_vector (N-1 downto 0);
           reset         : in  std_logic;
           out_c        : out std_logic_vector(2*N-1 downto 0)
          );
end mult_rtl;

architecture Multiplication of mult_rtl is
  signal c_temp : std_logic_vector (2*N-1 downto 0);
begin
c_temp <= i_a*i_b;
 process(c_temp,reset)
   begin
     if reset = '1' then
       out_c <= (others =>'0');
     else
       out_c <= (c_temp(2*N-2 downto 0))&'0'; 
     end if;
  end process;
end Multiplication;
