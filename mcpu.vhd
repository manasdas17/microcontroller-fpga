----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:06:15 03/25/2014 
-- Design Name: 
-- Module Name:    mcpu - Behavioral 
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

entity mcpu is
	Port (clock_1: in STD_LOGIC;
			clock_2: in STD_LOGIC;
			data_out: out STD_LOGIC_VECTOR (3 downto 0));
end mcpu;

architecture arch of mcpu is
	component instruction_register is
			Generic ( size: integer :=16);
			Port (data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
					data_out : out  STD_LOGIC_VECTOR (size-1 downto 0));
	end component;

	component status_register is
			Generic ( size: integer :=8);
			Port (data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
					data_out : out  STD_LOGIC_VECTOR (size-1 downto 0));
	end component;
	
	component program_counter is
		Generic ( size: integer :=4);
		Port (addr_in: in STD_LOGIC_VECTOR (size-1 downto 0);
				addr_in_sel: in STD_LOGIC;
				addr_clock: in STD_LOGIC;
				result_clock: in STD_LOGIC;
				data_out: out STD_LOGIC_VECTOR (size-1 downto 0));
	end component;

	component register_bank is
		Generic ( size: integer :=4);
		Port (data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
				data_out: out STD_LOGIC_VECTOR (size-1 downto 0);
				read_addr_bus: in STD_LOGIC_VECTOR (1 downto 0);
				write_addr_bus: in STD_LOGIC_VECTOR (1 downto 0);
				clock : in  STD_LOGIC);
	end component;	

	component rom is
		 Port (I_INSTRUCTION_ADR : in std_logic_vector(3 downto 0);
				 O_INSTRUCTION : out std_logic_vector(15 downto 0));
	end component;

	component alu is
		Generic ( size: integer :=4);
		Port ( x_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  y_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			  sum : out  STD_LOGIC_VECTOR (size-1 downto 0);
			  carry: out STD_LOGIC);
	end component;	

	signal ir_out, rom_out: STD_LOGIC_VECTOR (15 downto 0);
	signal rb_out, rom_in, sr_in, sr_out: STD_LOGIC_VECTOR (3 downto	 0);
begin
	rm: rom port map(rom_in, rom_out);
	ir: instruction_register port map(
		data_in => rom_out,
		data_out => ir_out
	);
	sr: status_register port map(
		data_in => sr_in,
		data_out => sr_out
	);
	rb: register_bank port map(
		data_in => ir_out(3 downto 0),
		data_out => rb_out,
		read_addr_bus => ir_out(11 downto 10),
		write_addr_bus => ir_out(9 downto 8),
		clock => ir_out(12)
	);
	pc:  program_counter port map(
		addr_in => ir_out(3 downto 0),
		addr_in_sel => ir_out(13),
		addr_clock => clock_1,
		result_clock => clock_2,
		data_out => rom_in
	);
end arch;

