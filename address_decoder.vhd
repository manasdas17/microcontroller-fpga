----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:44:56 03/19/2014 
-- Design Name: 
-- Module Name:    address_decoder - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity address_decoder is
    Port ( data_in : in  STD_LOGIC_VECTOR (1 downto 0);
           data_out : out  STD_LOGIC_VECTOR (3 downto 0));
end address_decoder;

architecture arch of address_decoder is

begin	
	gen:
		for i in 3 downto 0 generate
			data_out(i) <= '1' WHEN to_integer(unsigned(data_in))=i ELSE '0';
		end generate;
end arch;

