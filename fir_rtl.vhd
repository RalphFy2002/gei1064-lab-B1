----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2025 07:22:33 PM
-- Design Name: 
-- Module Name: fir_rtl - structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fir_rtl is
  Port (
    x_in: in std_logic_vector(7 downto 0);
    s_out: out std_logic_vector(15 downto 0);
    w1, w2, w3, w4, w5: in std_logic_vector(7 downto 0);
    clk : in std_logic;
    reset : in std_logic   
   );
end fir_rtl;

architecture structural of fir_rtl is

component pe_fir_rtl is
  generic (N : integer := 8);
  port(
    i_x, w      : in  std_logic_vector(N-1 downto 0);
    i_s         : in  std_logic_vector(2*N-1 downto 0);
    reset, clk  : in  std_logic;
    out_s       : out std_logic_vector(2*N-1 downto 0);
    out_x       : out std_logic_vector(N-1 downto 0)
  );
end component;


-- Signaux de connexion entre les PEs pour x
signal x1_x2 : std_logic_vector(7 downto 0);
signal x2_x3 : std_logic_vector(7 downto 0);
signal x3_x4 : std_logic_vector(7 downto 0);
signal x4_x5 : std_logic_vector(7 downto 0);

-- Signaux de connexion entre les PEs pour s
signal s1_s2 : std_logic_vector(15 downto 0);
signal s2_s3 : std_logic_vector(15 downto 0);
signal s3_s4 : std_logic_vector(15 downto 0);
signal s4_s5 : std_logic_vector(15 downto 0);

-- signal d'initialisation du premier PE
signal z_init: std_logic_vector(15 downto 0) := (others => '0');

begin

  -- ========================
  -- PE1 : Premier étage
  -- ========================
pe1 : pe_fir_rtl
    generic map (N => 8)
    port map (
      i_x   => x_in,
      w     => w1,
      i_s   => z_init,
      reset => reset,
      clk   => clk,
      out_s => s1_s2,
      out_x => x1_x2
    );
  

  -- PE2 : Deuxième étage

  pe2 : pe_fir_rtl
    generic map (N => 8)
    port map (
      i_x   => x1_x2,
      w     => w2,
      i_s   => s1_s2,
      reset => reset,
      clk   => clk,
      out_s => s2_s3,
      out_x => x2_x3
    );
  
  -- PE3 : Troisième étage
  pe3 : pe_fir_rtl
    generic map (N => 8)
    port map (
      i_x   => x2_x3,
      w     => w3,
      i_s   => s2_s3,
      reset => reset,
      clk   => clk,
      out_s => s3_s4,
      out_x => x3_x4
    );
  
  -- PE4 : Quatrième étage
  pe4 : pe_fir_rtl
    generic map (N => 8)
    port map (
      i_x   => x3_x4,
      w     => w4,
      i_s   => s3_s4,
      reset => reset,
      clk   => clk,
      out_s => s4_s5,
      out_x => x4_x5
    );
  
 
  -- PE5 : Cinquième étage (dernier)
  pe5 : pe_fir_rtl
    generic map (N => 8)
    port map (
      i_x   => x4_x5,
      w     => w5,
      i_s   => s4_s5,
      reset => reset,
      clk   => clk,
      out_s => s_out,
      out_x => open    
    );



end structural;
