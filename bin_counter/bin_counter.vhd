--------------------------------------------------------------------------------
-- Company: @pedruino
-- Engineer: Pedro Escobar
--
-- Create Date:    19:35:46 05/24/18
-- Design Name:    
-- Module Name:    Binary Counter - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_counter is
    Port ( reset : in std_logic;
           clock : in std_logic;
           output : out std_logic_vector(3 downto 0));
end bin_counter;

architecture Behavioral of bin_counter is
	signal count : integer range 25000000 downto 0;
	signal led : std_logic_vector (3 downto 0);
begin

process (clock, reset) 
	begin
	   if reset='1' then 
	      count <= 0;
		  led <= (others => '0'); -- "0000"
	   elsif clock='1' and clock'event then

	      if count = 25000000 then
		  	led <= led + 1;
			count <= 0;  
		  else
			count <= count + 1;
	      end if;

	   end if;
	end process;

	output <= led;

end Behavioral;
