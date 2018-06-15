--------------------------------------------------------------------------------
-- Company: @pedruino
-- Engineer: Pedro Escobar
--
-- Create Date:    21:21:09 05/24/18
-- Design Name:    
-- Module Name:    BCD Counter - Behavioral
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

entity bcd_counter is
    Port ( reset : in std_logic;
           clock : in std_logic;
           display : out std_logic_vector(7 downto 0);
           trigger : out std_logic);
end bcd_counter;

architecture Behavioral of bcd_counter is
--variables
	signal clock_count : integer range 25000000 downto 0;
	signal decimal : integer range 10 downto 0;
	signal digit : std_logic_vector(7 downto 0) := "11111111";
	signal is_enable : std_logic;
begin

process (clock, reset)
	begin
		if reset='1' then
			decimal <= 0;
			clock_count <= 0;
			digit <= (others => '1');
			is_enable <= '1';
		elsif clock='1' and clock'event then
			is_enable <= '0';
			
			if clock_count = 25000000 then
				clock_count <= 0;
			
				if decimal < 9 then
					decimal <= decimal + 1;
				else
					decimal <= 0;
				end if;
				
			else
				clock_count <= clock_count + 1;
			end if;

			if decimal = 0 then
				digit <= "11000000";
			elsif decimal = 1 then
				digit <= "11111001";
			elsif decimal = 2 then
				digit <= "10100100";
			elsif decimal = 3 then
				digit <= "10110000";
			elsif decimal = 4 then
				digit <= "10011001";
			elsif decimal = 5 then
				digit <= "10010010";
			elsif decimal = 6 then
				digit <= "10000010";
			elsif decimal = 7 then
				digit <= "11111000";
			elsif decimal = 8 then
				digit <= "10000000";
			else
				digit <= "10010000";
			end if;

		end if;
	end process;

	display <= digit;
	trigger <= is_enable;

end Behavioral;
