----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:31 03/19/2014 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
	 Generic ( size: integer :=4);
    Port ( x_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
           y_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  sum : out  STD_LOGIC_VECTOR (size-1 downto 0);
			  carry: out STD_LOGIC);
end alu;

architecture arch of alu is
	signal full_added_carry_signal : STD_LOGIC_VECTOR (size downto 0);
	
	component full_adder
		port(
			x: in STD_LOGIC;
			y: in STD_LOGIC;
			carry_in: in STD_LOGIC;
			sum_out: out STD_LOGIC;
			carry_out: out STD_LOGIC);
	end component;

begin
	-- the carry_in signal for the fist full adder is connected to ground.
	full_added_carry_signal(0) <= '0';
	
	-- the carry_out from the last full adder is connected to the alu's carry out port.
	carry <= full_added_carry_signal(size);

	gen:
		for i in 0 to size-1 generate
			fa: full_adder port map(x_in(i), y_in(i), full_added_carry_signal(i), sum(i), full_added_carry_signal(i+1));
		end generate;
end arch;


