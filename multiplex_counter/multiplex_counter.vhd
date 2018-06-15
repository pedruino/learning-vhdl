--------------------------------------------------------------------------------
-- Company: @pedruino
-- Engineer: Pedro Escobar
--
-- Create Date:    23:10:43 06/07/18
-- Design Name:    
-- Module Name:    Multiplex Counter - Behavioral
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

entity multiplex_counter is
    Port ( clock : in std_logic;
           reset : in std_logic;
           display : out std_logic_vector(6 downto 0);
           trigger : out std_logic_vector(3 downto 0));
end multiplex_counter;

architecture Behavioral of multiplex_counter is
	function decode(number: integer) return std_logic_vector is variable output: std_logic_vector (6 downto 0);
		--display common anode
		begin 
			if number = 0 then output := "1000000";
			elsif number = 1 then output := "1111001";
			elsif number = 2 then output := "0100100";
			elsif number = 3 then output := "0110000";
			elsif number = 4 then output := "0011001";
			elsif number = 5 then output := "0010010";
			elsif number = 6 then output := "0000010";
			elsif number = 7 then output := "1111000";
			elsif number = 8 then output := "0000000";
			else output := "0010000";
			end if;
		return(output);
	end decode;
--variables
	signal clock_count : integer range 25000000 downto 0;	
	signal unit: integer range 10 downto 0 := 0;
	signal ten: integer range 10 downto 0 := 0;
	signal hundred: integer range 10 downto 0 := 0;
	signal thousand: integer range 10 downto 0 := 0;
	signal number : integer range 10 downto 0;	
	signal digit : std_logic_vector (6 downto 0) := (others => '1');
	signal is_enable : std_logic_vector(3 downto 0) := (others => '1');
	signal multiplex: integer range 20000 downto 0 := 0;	
begin

process (clock, reset)
	begin
		if reset='1' then
			number <= 0;
			clock_count <= 0;
			digit <= (others => '1');
			is_enable <= (others => '1');  -- enable(0) disable(1) { transistor NPN } 
	   elsif clock='1' and clock'event then
			if clock_count = 1000000 then
				clock_count <= 0;
				
				if (thousand = 10) then
					thousand <= 0;
					hundred <= 0;
					ten <= 0;
					unit <= 0;
				elsif(hundred = 10) then				
					hundred <= 0;
					ten <= 0;
					unit <= 0;
					thousand <= thousand + 1;
				elsif(ten = 10) then				
					ten <= 0;
					unit <= 0;
					hundred <= hundred + 1;
				elsif(unit = 9) then
					unit <= 0;
					ten <= ten + 1;
				else
					unit <= unit + 1;
				end if;

			else
				clock_count <= clock_count + 1;
				multiplex <= multiplex + 1;
	      end if;

			if multiplex = 20000 then
				multiplex <= 0;
				is_enable <= "0111";
				digit <= decode(thousand);
			elsif multiplex = 15000 then
				is_enable  <= "1011";
				digit <= decode(hundred);			
			elsif multiplex = 10000 then
				is_enable  <= "1101";
				digit <= decode(ten);			
			elsif multiplex = 5000 then
				is_enable  <= "1110";
				digit <= decode(unit);
			end if;
			
		end if;					
	end process;
	
	display <= digit;
	trigger <= is_enable;
	
end Behavioral;
