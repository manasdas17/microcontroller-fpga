----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:25 03/19/2014 
-- Design Name: 
-- Module Name:    register_bank - Behavioral 
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

entity register_bank is
	Generic ( size: integer :=4);
	Port (data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			data_out: out STD_LOGIC_VECTOR (size-1 downto 0);
			read_addr_bus: in STD_LOGIC_VECTOR (1 downto 0);
			write_addr_bus: in STD_LOGIC_VECTOR (1 downto 0);
			clock : in  STD_LOGIC);
end register_bank;

architecture arch of register_bank is
	-- signals going out of the address decoders for the address and data bus.
	signal read_addr_decoded, write_addr_decoded: STD_LOGIC_VECTOR (3 downto 0);

	-- holds and value of clock and address bus. determines if a register cell is clocked.
	signal is_clocked: STD_LOGIC_VECTOR (3 downto 0);

	-- signals going out of the registry cells.
	type signal_matrix is ARRAY (3 downto 0) of STD_LOGIC_VECTOR (3 downto 0);
	signal register_cells_out: signal_matrix;
	
	-- 
	signal data_bus: STD_LOGIC_VECTOR (3 downto 0);

	component address_decoder is
	 Port ( data_in : in  STD_LOGIC_VECTOR (1 downto 0);
			  data_out : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component register_cell is
		Generic ( size: integer :=4);
		Port (data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
				data_out: out STD_LOGIC_VECTOR (size-1 downto 0);
				clock : in  STD_LOGIC);
	end component;
begin
	ab: address_decoder port map(read_addr_bus, read_addr_decoded);
	db: address_decoder port map(write_addr_bus, write_addr_decoded);
	gen:
	  for i in size-1 downto 0 generate
			is_clocked(i) <= clock and write_addr_decoded(i);
			rc: register_cell port map(data_in, register_cells_out(i), is_clocked(i));
			data_out <= register_cells_out(i) when (read_addr_decoded(i) = '1') else(3 downto 0 => 'Z');
	  end generate;   
end arch;

