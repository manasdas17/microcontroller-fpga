----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:42 04/06/2014 
-- Design Name: 
-- Module Name:    accumulator - Behavioral 
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

entity accumulator is
	Generic ( size: integer :=4);
	Port (sel_ldi: in STD_LOGIC;
			acc_enable: in STD_LOGIC;
			clock_1: in STD_LOGIC;
			clock_2: in STD_LOGIC;
			sel_imm: in STD_LOGIC;
			data_in : in  STD_LOGIC_VECTOR (size-1 downto 0);
			data_in_imm : in  STD_LOGIC_VECTOR (size-1 downto 0);
			data_out : out  STD_LOGIC_VECTOR (size-1 downto 0);
			carry: out STD_LOGIC);
	
end accumulator;

architecture arch of accumulator is
	signal 	input_cell_in,
				input_cell_out,
				result_cell_in,
				alu_y_in,
				alu_out: STD_LOGIC_VECTOR (size-1 downto 0);

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
	input_cell: register_cell port map(
		data_in => input_cell_in,
		data_out => input_cell_out,
		clock => (acc_enable and clock_2)
	);

	result_cell_in <= data_in_imm when sel_ldi='1' else alu_out;
	result_cell: register_cell port map(
		data_in => result_cell_in,
		data_out => input_cell_in,
		clock => clock_1
	); 
	
	alu_y_in <= data_in_imm when sel_imm='1' else data_in;
	al: alu port map(
		x_in => input_cell_out,
		y_in => alu_y_in,
		sum => alu_out,
		carry => carry
	);
	data_out <= input_cell_in;
end arch;

