----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:36:59 03/19/2014 
-- Design Name: 
-- Module Name:    register_cell - Behavioral 
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

entity register_cell is
	 Generic ( size: integer :=4);
    Port ( data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  data_out: out STD_LOGIC_VECTOR (size-1 downto 0);
			  clock : in  STD_LOGIC);
end register_cell;

architecture arch of register_cell is

	component flip_flop
		port(
			data: in STD_LOGIC;
			clock: in STD_LOGIC;
			value: out STD_LOGIC);
	end component;

begin
	gen:
		for index in size-1 downto 0 generate
			fp: flip_flop port map(data_in(index), clock, data_out(index));
		end generate;
end arch;

