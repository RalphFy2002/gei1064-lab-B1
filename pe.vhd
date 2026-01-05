----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2025 05:54:22 PM
-- Design Name: 
-- Module Name: pe_fir_rtl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Processeur élémentaire pour filtre FIR avec composants
-- 
-- Dependencies: mult_rtl, add_rtl, reg_rtl
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pe_fir_rtl is
  generic (N : integer := 8);
  port(
    i_x, w      : in  std_logic_vector(N-1 downto 0);
    i_s         : in  std_logic_vector(2*N-1 downto 0);
    reset, clk  : in  std_logic;
    out_s       : out std_logic_vector(2*N-1 downto 0);
    out_x       : out std_logic_vector(N-1 downto 0)
  );
end pe_fir_rtl;

architecture Behavioral of pe_fir_rtl is
  
  -- ========================
  -- Component Declarations
  -- ========================
  component reg_rtl is
    generic (N : integer := 8);
    port(
      i_r       : in  std_logic_vector(N-1 downto 0);
      reset, clk: in  std_logic;
      out_r     : out std_logic_vector(N-1 downto 0)
    );
  end component;
  
  component add_rtl is
    generic (M : integer := 16);
    port (
      i_a, i_b  : in  std_logic_vector(M-1 downto 0);
      reset     : in  std_logic;
      out_s     : out std_logic_vector(M-1 downto 0)
    );
  end component;
  
  component mult_rtl is
    generic (N : integer := 8);
    port (
      i_a, i_b  : in  std_logic_vector(N-1 downto 0);
      reset     : in  std_logic;
      out_c     : out std_logic_vector(2*N-1 downto 0)
    );
  end component;
  
  -- ========================
  -- Internal Signals
  -- ========================
  signal mult_out : std_logic_vector(2*N-1 downto 0);  -- Sortie du multiplieur
  signal add_out  : std_logic_vector(2*N-1 downto 0);  -- Sortie de l'additionneur
  signal x_delayed: std_logic_vector(N-1 downto 0);    -- x retardé d'un cycle
  signal s_reg    : std_logic_vector(2*N-1 downto 0);  -- s registré
  
begin
  
  -- ========================
  -- Instantiate Register for X
  -- Retarde i_x d'un cycle d'horloge
  -- ========================
  reg1 : reg_rtl port map(i_x, reset, clk, x_delayed);
  
  -- ========================
  -- Instantiate Multiplier
  -- Multiplication: mult_out = i_x * w
  -- ========================
  mult1 : mult_rtl port map(i_x, w, reset, mult_out);
  
  -- ========================
  -- Instantiate Adder
  -- Addition: add_out = mult_out + i_s
  -- ========================
  add1 : add_rtl port map(i_s, mult_out, reset, add_out);
  
  -- ========================
  -- Instantiate Register for S
  -- Retarde add_out d'un cycle d'horloge
  -- ========================
--  reg2 : reg_rtl port map(add_out, reset, clk, s_reg);
  
  -- ========================
  -- Output Assignments
  -- ========================
  out_x <= x_delayed;
  out_s <= add_out;
  
  
end Behavioral;