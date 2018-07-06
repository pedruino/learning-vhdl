--------------------------------------------------------------------------------
-- Company: @pedruino
-- Engineer: Pedro Escobar
--
-- Create Date:    21:44:58 06/28/18
-- Design Name:    
-- Module Name:    VGA Render - Behavioral
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

entity vga_render is
    Port ( reset : in std_logic;
           clock : in std_logic;
           trigger : in std_logic_vector(7 downto 0);
           vsync : out std_logic;
           hsync : out std_logic;
           output : out std_logic_vector(7 downto 0));
end vga_render;

architecture Behavioral of vga_render is
	signal count_h: integer range 432 downto 0; --horizontal timer
	signal h_sync: std_logic;
begin

process (clock, reset)
begin
	if reset='1' then
		count_h <= 0;
	elsif clock='1' and clock'event then
		
		if count_h = 432 then
			count_h <= 0;
		elsif count_h = 0 then
			h_sync <= 0; --initialize h-sync with zero
		elsif count_h = 51 then
			h_sync <= 1;
		else
			count_h <= count_h + 1;
		end if;
		
	end if;
end process;

output <= trigger;

end Behavioral;
