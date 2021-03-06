----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:06:21 03/20/2014 
-- Design Name: 
-- Module Name:    program_counter - Behavioral 
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

entity program_counter is
	Generic ( size: integer :=4);
	Port (addr_in: in STD_LOGIC_VECTOR (size-1 downto 0);
			addr_in_sel: in STD_LOGIC;
			addr_clock: in STD_LOGIC;
			result_clock: in STD_LOGIC;
			data_out: out STD_LOGIC_VECTOR (size-1 downto 0));
end program_counter;

architecture arch of program_counter is
	signal 	addr_cell_out,
				alu_in,
				alu_to_result_cell,
				addr_cell_in,
				result_cell_out: STD_LOGIC_VECTOR (size-1 downto 0);

	component register_cell is
		Generic ( size: integer :=size);
		Port ( data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  data_out: out STD_LOGIC_VECTOR (size-1 downto 0);
			  clock : in  STD_LOGIC);
	end component;
	
	component alu is
		Generic ( size: integer :=size);
		Port ( x_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  y_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  sum : out  STD_LOGIC_VECTOR (size-1 downto 0);
			  carry: out STD_LOGIC);
	end component;	
begin
		addr_cell_in <= addr_in when addr_in_sel='1' else result_cell_out;
		addr_cell : register_cell port map(
							data_in => addr_cell_in,
							data_out => addr_cell_out,
							clock => addr_clock);
		al : alu port map (
						x_in => alu_in,
						y_in => (size-1 downto 1 => '0', others => '1'),
						sum => alu_to_result_cell,
						carry => open);
		result_cell : register_cell port map(
							data_in => alu_to_result_cell,
							data_out => result_cell_out,
							clock => result_clock);
		process (addr_clock)
			begin 
				if( addr_clock = '1') then
					alu_in <= (size-1 downto 0 => 'Z'); 
				else
					alu_in <= addr_cell_out; 
				end if; 
				data_out <= addr_cell_out;
		end process;		
end arch;

