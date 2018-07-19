--------------------------------------------------------------------------------
-- Company: @pedruino
-- Engineer: Pedro Escobar
--
-- Create Date:    23:18:40 07/05/18
-- Design Name:    
-- Module Name:  A simple functional test - Behavioral
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

entity functional_test is
    Port ( clock : in std_logic;
           reset : in std_logic;
           trigger : out std_logic_vector(3 downto 0);
           display : out std_logic_vector(7 downto 0);
           leds : out std_logic_vector(7 downto 0);
           tx : out std_logic;
           sw_serial : in std_logic;
           sw_counter : in std_logic;
           sw_led : in std_logic);
end functional_test;

architecture Behavioral of functional_test is

--functions
    function decode(number: integer) return std_logic_vector is variable output: std_logic_vector (7 downto 0);
		--display common anode
		begin 
			if number = 0 then output := "11000000";
			elsif number = 1 then output := "11111001";
			elsif number = 2 then output := "10100100";
			elsif number = 3 then output := "10110000";
			elsif number = 4 then output := "10011001";
			elsif number = 5 then output := "10010010";
			elsif number = 6 then output := "10000010";
			elsif number = 7 then output := "11111000";
			elsif number = 8 then output := "10000000";
            elsif number = 9 then output := "10010000";
            elsif number = 10 then output := "10001000";
            elsif number = 11 then output := "10000011";
            elsif number = 12 then output := "11000110";
            elsif number = 13 then output := "10100001";
            elsif number = 14 then output := "10000110";
            elsif number = 15 then output := "10001110";
			else output := "11000000";            
			end if;
		return(output);
	end decode;

    function bit_serial (conta: integer; letra: std_logic_vector) return std_logic is
    variable transmite: std_logic;
        begin
            if conta = 0 then transmite := '1';--idle
            elsif conta = 1 then transmite := '0';--start bit
            elsif conta = 2 then transmite := letra (0);
            elsif conta = 3 then transmite := letra (1);
            elsif conta = 4 then transmite := letra (2);
            elsif conta = 5 then transmite := letra (3);
            elsif conta = 6 then transmite := letra (4);
            elsif conta = 7 then transmite := letra (5);
            elsif conta = 8 then transmite := letra (6);
            elsif conta = 9 then transmite := letra (7);
            elsif conta = 10 then transmite := '0';--stop bit
            else transmite := '1';--idle
            end if;
        return(transmite);
    end bit_serial;

    function char_to_bin(char: character) return std_logic_vector is 
    variable binary: std_logic_vector (7 downto 0);
		begin
            case char is                
                when '!' => return	"0100001";
                when '"' => return	"0100010";
                when '#' => return	"0100011";
                when '$' => return	"0100100";
                when '%' => return	"0100101";
                when '&' => return	"0100110";
                when ''' => return	"0100111";
                when '(' => return	"0101000";
                when ')' => return	"0101001";
                when '*' => return	"0101010";
                when '+' => return	"0101011";
                when ',' => return	"0101100";
                when '-' => return	"0101101";
                when '.' => return	"0101110";
                when '/' => return	"0101111";
                when '0' => return	"0110000";
                when '1' => return	"0110001";
                when '2' => return	"0110010";
                when '3' => return	"0110011";
                when '4' => return	"0110100";
                when '5' => return	"0110101";
                when '6' => return	"0110110";
                when '7' => return	"0110111";
                when '8' => return	"0111000";
                when '9' => return	"0111001";
                when ':' => return	"0111010";
                when ';' => return	"0111011";
                when '<' => return	"0111100";
                when '=' => return	"0111101";
                when '>' => return	"0111110";
                when '?' => return	"0111111";
                when '@' => return	"01000000";
                when 'A' => return	"01000001";
                when 'B' => return	"01000010";
                when 'C' => return	"01000011";
                when 'D' => return	"01000100";
                when 'E' => return	"01000101";
                when 'F' => return	"01000110";
                when 'G' => return	"01000111";
                when 'H' => return	"01001000";
                when 'I' => return	"01001001";
                when 'J' => return	"01001010";
                when 'K' => return	"01001011";
                when 'L' => return	"01001100";
                when 'M' => return	"01001101";
                when 'N' => return	"01001110";
                when 'O' => return	"01001111";
                when 'P' => return	"01010000";
                when 'Q' => return	"01010001";
                when 'R' => return	"01010010";
                when 'S' => return	"01010011";
                when 'T' => return	"01010100";
                when 'U' => return	"01010101";
                when 'V' => return	"01010110";
                when 'W' => return	"01010111";
                when 'X' => return	"01011000";
                when 'Y' => return	"01011001";
                when 'Z' => return	"01011010";
                when '[' => return	"01011011";
                when '\' => return	"01011100";
                when ']' => return	"01011101";
                when '^' => return	"01011110";
                when '_' => return	"01011111";
                when '`' => return	"01100000";
                when 'a' => return	"01100001";
                when 'b' => return	"01100010";
                when 'c' => return	"01100011";
                when 'd' => return	"01100100";
                when 'e' => return	"01100101";
                when 'f' => return	"01100110";
                when 'g' => return	"01100111";
                when 'h' => return	"01101000";
                when 'i' => return	"01101001";
                when 'j' => return	"01101010";
                when 'k' => return	"01101011";
                when 'l' => return	"01101100";
                when 'm' => return	"01101101";
                when 'n' => return	"01101110";
                when 'o' => return	"01101111";
                when 'p' => return	"01110000";
                when 'q' => return	"01110001";
                when 'r' => return	"01110010";
                when 's' => return	"01110011";
                when 't' => return	"01110100";
                when 'u' => return	"01110101";
                when 'v' => return	"01110110";
                when 'w' => return	"01110111";
                when 'x' => return	"01111000";
                when 'y' => return	"01111001";
                when 'z' => return	"01111010";
                when '{' => return	"01111011";
                when '|' => return	"01111100";
                when '}' => return	"01111101";
                when '~' => return	"01111110";
                when others => return "11111111";
            end case;        
	end char_to_bin;

--variables
    signal number : integer range 15 downto 0 := 0;
    signal count_leds : std_logic_vector (7 downto 0) := (others => '0');	
    signal digit : std_logic_vector (7 downto 0) := (others => '1');	 
    signal delay : integer range 0 to 100000;
    signal memory_sw_counter, memory_sw_led: std_logic;
--[serial]
    signal divisor : integer range 5208 downto 0 := 0;
    signal conta : integer range 255 downto 0 := 0;
    signal transmite : std_logic;
    signal indice : integer range 7 downto 0 := 0;
    --signal f : std_logic_vector (7 downto 0);
    --signal t : std_logic_vector (7 downto 0);
    --signal e : std_logic_vector (7 downto 0);
    --signal c : std_logic_vector (7 downto 0);
    signal b : std_logic_vector (7 downto 0);

    signal p : std_logic_vector (7 downto 0);
    signal e : std_logic_vector (7 downto 0);
    signal d : std_logic_vector (7 downto 0);
    signal r : std_logic_vector (7 downto 0);
    signal o : std_logic_vector (7 downto 0);

begin

process (clock, reset, sw_counter, sw_led, sw_serial)
begin
	
    if reset='1' then
        number <= 0;
		delay <= 0;
		memory_sw_counter <= '0';
		memory_sw_led <= '0';
		digit <= (others => '1');
        count_leds <= (others => '0');
        --serial
        transmite <= '1';
		divisor <= 0;

		b <= "00100000";--32 eh o codigo do espaço na tabela ascii
		
        p <= char_to_bin('p');
		e <= char_to_bin('a');
		d <= char_to_bin('u');
		r <= char_to_bin('l');
        o <= char_to_bin('o');
		
        conta <= 0;
		indice <= 0;

	elsif clock='1' and clock'event then

        -- Button Counter
        if sw_counter = '1' then
		    memory_sw_counter <= '1';
		    delay <= 0;            
        elsif sw_counter = '0' and memory_sw_counter = '1' then --fim do pulso de clock	inicia delay de ruído da chave
		    delay <= delay + 1;
            
            if delay = 100000 then --final do delay de chave, ações a serem executadas no final do pulso de clock			   
			    memory_sw_counter <= '0'; --reset da memória da chave
			    number <=  number + 1; --ação quando sw_counter foi acionada					
		    end if;
        
        --Button LEDs
        elsif sw_led = '1' then
		    memory_sw_led <= '1';
		    delay <= 0; 
        elsif sw_led = '0' and memory_sw_led = '1' then --fim do pulso de clock	inicia delay de ruído da chave
		    delay <= delay + 1;
            
            if delay = 100000 then --final do delay de chave, ações a serem executadas no final do pulso de clock
			    memory_sw_led <= '0';  --reset da memória da chave
		 	    count_leds <=  count_leds + 1; --ação quando s2 foi acionada					
		    end if;

        --Button SERIAL
        elsif sw_serial = '1' then
		    --SERIAL
            if divisor = 5208 then --contou t = 1/9600 bps
                divisor <= 0;			   
                conta <= conta + 1;--incrementa indice de bits
                
                if conta = 255 then--11 a 255 estado de idle 
                    conta <= 0;			
                    indice <= indice + 1;		
                    
                    if indice = 5 then 
                        indice <= 0;
                    end if;

                end if;

            else
                divisor <= divisor + 1;

                if indice = 0 then	
                    transmite <= bit_serial(conta,p);	    			
                elsif indice = 1 then	
                    transmite <= bit_serial(conta,e);
                elsif indice = 2 then	
                    transmite <= bit_serial(conta,d);
                elsif indice = 3 then	
                    transmite <= bit_serial(conta,r);
                elsif indice = 4 then	
                    transmite <= bit_serial(conta,o);
                elsif indice = 5 then	
                    transmite <= bit_serial(conta,b);
                else 
                    transmite <= '1';
                end if;

            end if;

        end if;--sw_counter then

	end if;--clock'event then
    
    digit <= decode(number);
end process;
    tx <= transmite;
    leds <= count_leds;          
    display <= digit;
    trigger <= "1110";
end Behavioral;
