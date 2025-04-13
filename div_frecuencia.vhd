library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div_frecuencia is
	port(
		clk: in std_logic;
		n_ciclos: in integer; --número de ciclos
		f: out std_logic
	);
end div_frecuencia;

architecture sd2 of div_frecuencia is
	signal salida: std_logic;
	signal cuenta: integer range 0 to 25000000 := 0;
	
begin
	process(clk)
	begin 
		
		if rising_edge(clk) then
			if cuenta >= n_ciclos-1 then
				cuenta <= 0;
				salida <= not salida;
			else
				cuenta <= cuenta+1;
			end if;
		end if;
	end process;
	
	f <= salida;
end sd2;