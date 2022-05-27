----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:28:29 05/23/2022 
-- Design Name: 
-- Module Name:    MaquinaExpendedora - Behavioral 
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

--Programar la entidad MaquinExpendedora
entity MaquinaArcade is
Port (clk, coin, ok, P2, star, finaliza : in STD_LOGIC;
		devolver : out std_logic;
		aux : inout std_logic_vector (2 downto 0));
end MaquinaArcade;

--Programación de la Arquitectura de la máquina de estados.

architecture Behavioral of MaquinaArcade is

--Generando los estados relación Diagrama de Estados

Type estado is (A, B, C, D, E);

--Genero los estados

signal estate_fut, estate_act: estado;

begin
	process(estate_act, coin, ok, P2, star , finaliza) begin
		case estate_act is
		--primer estado
			when A =>
				devolver <= '0';
				aux <= "000";
				if coin = '1' then estate_fut <= B;
				else estate_fut <= A;
				end if;
		--segundo estado
			when B =>
				aux <= "001";
				if ok = '1' then 
				devolver <= '0';
				estate_fut <= C;
				else 
				devolver <= '1';
				estate_fut <= A;
				end if;
		--tercer estado
			when C =>
				devolver<= '0';
				aux <= "010";
				if P2 = '1' then 
				estate_fut <= A;			
				else estate_fut <= D;
				end if;
		--cuarto estado
			when D =>
				devolver <= '0';
				aux <= "011";
				if star = '1' then estate_fut <= E;
				else estate_fut <= D;
				end if;
		--quinto estado
			when E =>
				devolver <= '0';
				aux <= "100";
				if finaliza = '1' then estate_fut <= A;
				else estate_fut <= E;
				end if;
		end case;
	end process;
	
	process (clk) is begin
		if(clk' event and clk ='1') then
		estate_act <= estate_fut;
		end if;
	end process;
	
end Behavioral;