--------------------------------------------------------------------------------
-- Company: @pedruino
-- Engineer: Pedro Escobar
--
-- Create Date:    21:19:36 06/14/18
-- Design Name:    
-- Module Name:    Serial Transmitter - Behavioral
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

entity serial_tx is
    Port ( clock : in std_logic;
           reset : in std_logic;
           tx : out std_logic);
end serial_tx;

architecture Behavioral of serial_tx is
	signal clock_count : integer range 5208 downto 0 := 0; --50000000/9600 bps
	signal delay: integer range 50 downto 0 := 0;
	signal data: std_logic; --memorize the bit to be transmitted
	signal char: std_logic_vector (7 downto 0); --character to be sended
begin

process (clock, reset)
	begin
		if reset='1' then			
			clock_count <= 0;
			char <= "01000000";--starts transmission with 32 ASCII code			
	   elsif clock='1' and clock'event then
			if	clock_count = 5208 then --1 clock /9600 bps
				clock_count <= 0;
				delay <= delay +1;

				if delay = 50 then
					delay <= 0;

					if char = "01111111" then --127 ASCII code
						char <= "01000000"; --back to 32	ASCII code
					else
						char <= char + 1;
					end if;

				end if;			
			else
				clock_count <= clock_count + 1;
				
				if delay = 0 then data <= '1';--idle
				elsif delay = 1 then data <= '0';
				elsif delay = 2 then data <= char(0);
				elsif delay = 3 then data <= char(1);
				elsif delay = 4 then data <= char(2);
				elsif delay = 5 then data <= char(3);
				elsif delay = 6 then data <= char(4);
				elsif delay = 7 then data <= char(5);
				elsif delay = 8 then data <= char(6);
				elsif delay = 9 then data <= char(7);
				elsif delay = 10 then data <= '0';
				else data <= '1';		
				end if;

			end if;			
		end if;
	end process;	
	
	tx <= data;

end Behavioral;
