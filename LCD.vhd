library ieee;
use ieee.std_logic_1164.all;

entity LCD is
port (
	clk: in std_logic;
	DOUT1 : in std_logic_vector (3 downto 0); -- Dato a leer
	DOUT2 : in std_logic_vector (3 downto 0); -- Dato a leer
	DOUT3 : in std_logic_vector (3 downto 0); -- Dato a leer
	e, rs, rw: out std_logic;
	datos: out std_logic_vector(7 downto 0)
);
end LCD;

architecture SD2 of LCD is
	type estados is (e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,IDLE); --se dan de alta los estados finitos, 2 señales por instrucción
	
	signal edo_pre, edo_fut: estados := e0; --estado presente y futuro de la instrucción
	begin

		proceso1: process(edo_pre)
		begin 
			case (edo_pre) is
			
			--configuración del LCD
			when e0 => 
				datos <= X"38"; --set (dato, linea y matriz) y modo de dos lineas
				e <= '1'; --sube la señal
				rs <= '0'; --indica que sera un comando
				rw <= '0'; 
				edo_fut <= e1; --estado siguiente
				
			when e1 =>
				e <= '0'; --baja la señal
				edo_fut <= e2; --estado siguiente
			
			--limpiar LCD
			when e2 =>
				datos <= X"01"; --clear display
				e <= '1'; 
				rs <= '0';
				rw <= '0';
				edo_fut <= e3;
				
			when e3 =>
				e <= '0';
				edo_fut <= e4;
				
			--activación de display y muestre el cursor
			when e4 =>
				datos <= X"0E"; --display y cursor ON
				e <= '1';
				rs <= '0';
				rw <= '0';
				edo_fut <= e5;
				
			when e5 =>
				e <= '0';
				edo_fut <= e6;
				
			--primer caracter
			when e6 =>
				e <= '1';
				rs <= '1'; --indica que es un caracter
				rw <= '0';--escribe caracter
			  case DOUT1 is
					when "0000" => datos <= X"30"; -- 0
					when "0001" => datos <= X"31"; -- 1
					when "0010" => datos <= X"32"; -- 2
					when "0011" => datos <= X"33"; -- 3
					when "0100" => datos <= X"34"; -- 4
					when "0101" => datos <= X"35"; -- 5
					when "0110" => datos <= X"36"; -- 6
					when "0111" => datos <= X"37"; -- 7
					when "1000" => datos <= X"38"; -- 8
					when "1001" => datos <= X"39"; -- 9
					when others => datos <= X"80"; -- Nada
				end case;
				edo_fut <= e7;
				
			when e7 =>
				e <= '0';
				edo_fut <= e8;
			
			--segundo caracter
			when e8 =>
				e <= '1';
				rs <= '0'; --indica que es un comando
				rw <= '0';
				case DOUT2 is
					when "0000" => datos <= X"30"; -- 0
					when "0001" => datos <= X"31"; -- 1
					when "0010" => datos <= X"32"; -- 2
					when "0011" => datos <= X"33"; -- 3
					when "0100" => datos <= X"34"; -- 4
					when "0101" => datos <= X"35"; -- 5
					when "0110" => datos <= X"36"; -- 6
					when "0111" => datos <= X"37"; -- 7
					when "1000" => datos <= X"38"; -- 8
					when "1001" => datos <= X"39"; -- 9
					when others => datos <= NULL; -- Nada
				end case;
				edo_fut <= e9;
				
			when e9 =>
				e <= '0';
				edo_fut <= e10;
			
			--tercer caracter
			when e10 =>
				e <= '1';
				rs <= '1'; --indica que es un caracter
				rw <= '0';
				case DOUT3 is
					when "0000" => datos <= X"30"; -- 0
					when "0001" => datos <= X"31"; -- 1
					when "0010" => datos <= X"32"; -- 2
					when "0011" => datos <= X"33"; -- 3
					when "0100" => datos <= X"34"; -- 4
					when "0101" => datos <= X"35"; -- 5
					when "0110" => datos <= X"36"; -- 6
					when "0111" => datos <= X"37"; -- 7
					when "1000" => datos <= X"38"; -- 8
					when "1001" => datos <= X"39"; -- 9
					when others => datos <= NULL; -- Nada
				end case;
				edo_fut <= e11;
				
			when e11 =>
				e <= '0';
				edo_fut <= IDLE;
			
			--estado inactivo
			when IDLE =>
				edo_fut <= IDLE; --se mantiene ahi
			end case;
		end process proceso1;
		
		proceso2: process (clk)
			variable pulsos: integer range 0 to 50000000;
				begin
					if(clk' event and clk='1') then
						if(pulsos=2500000) then --50ms
							pulsos := 0;
							edo_pre <= edo_fut;
						else 
							pulsos := pulsos+1;
						end if;
					end if;
					
				end process proceso2;
	end sd2;