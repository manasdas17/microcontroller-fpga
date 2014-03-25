----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:16 03/19/2014 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
			  carry_in: in STD_LOGIC;
           sum_out : out STD_LOGIC;
           carry_out : out STD_LOGIC);
end full_adder;

architecture arch of full_adder is
	signal h1_sum_out, h1_carry_out, h2_carry_out: STD_LOGIC;
	
	component half_adder
		port(
				x: in STD_LOGIC;
				y: in STD_LOGIC;
				sum: out STD_LOGIC;
				carry: out STD_LOGIC
				);
	end component;

begin
	h1: half_adder port map(x, y, h1_sum_out, h1_carry_out);
	h2: half_adder port map(h1_sum_out, carry_in, sum_out, h2_carry_out);

	carry_out <= h1_carry_out or h2_carry_out;
end arch;

