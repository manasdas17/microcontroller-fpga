----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:10 03/19/2014 
-- Design Name: 
-- Module Name:    flip_flop - Behavioral 
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

entity flip_flop is
    Port ( data : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           value : out  STD_LOGIC);
end flip_flop;

architecture arch of flip_flop is
	signal nand1_out, nand2_out, nand3_out, nand4_out: STD_LOGIC;

begin
	nand1_out <= data nand clock;
	nand2_out <= (not data) nand clock;
	nand3_out <= nand4_out nand nand1_out;
	nand4_out <= nand3_out nand nand2_out;
	
	value <= nand3_out;
	
end arch;

