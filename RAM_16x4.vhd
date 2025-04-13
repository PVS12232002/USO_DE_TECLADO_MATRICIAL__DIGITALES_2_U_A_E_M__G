library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
entity RAM_16x4 is
port 
   (
    WR   : in std_logic; 			-- Enable de escritura activo en alto
    DIN  : in std_logic_vector (3 downto 0);	-- Dato a escribir
	 lec_esc: in std_logic; --elige si es modo lectura o escritura
	 leds_procesos : out std_logic_vector(3 downto 0); --reflejo de procesos
	 DOUT1 : out std_logic_vector (3 downto 0);
	 DOUT2 : out std_logic_vector (3 downto 0);
    DOUT3 : out std_logic_vector (3 downto 0) -- Dato a leer
   );
end entity RAM_16x4;

architecture RAM_BEHAVIOR of RAM_16x4 is
subtype WORD is std_logic_vector (3 downto 0); -- tamaño del dato
type MEMORY is array (0 to 15) of WORD;        -- tamaño de la memoria
signal E, V, A : MEMORY;  -- señal para manejo de la RAM
signal contador,CONTADOR2 : INTEGER := 0;  --contadores								 
begin
	process (WR, DIN, lec_esc)
	variable RAM_ADDR_IN: integer range 0 to 98;	-- variable para la dirección  
	begin
		if (lec_esc = '1' and WR = '1') then --modo de escritura
			CONTADOR2 <= 0;
			leds_procesos <= "0000";
			case contador is
				when 0 =>
					RAM_ADDR_IN := conv_integer(DIN); --ingresa el lugar donde se guardara el dato
					contador <= 1;
					leds_procesos <= "1000"; --brilla led 3
				when 1 =>
					leds_procesos <= "0001";--brilla led 0
					E(RAM_ADDR_IN) <= DIN; --primer dato a la memoria
					contador <= 2;	
				when 2 =>
					leds_procesos <= "0010"; --brilla led 1
					V(RAM_ADDR_IN) <= DIN; --segundo dato a la memoria
					contador <= 3;
				when 3 =>
					leds_procesos <= "0100"; --brilla led 2
					A(RAM_ADDR_IN) <= DIN; --tercer dato a la memoria
					contador <= 0;
				when others => NULL;  
			end case;
		elsif (lec_esc = '0' and WR = '1') then --modo de lectura
			contador <= 0;
			leds_procesos <= "0000";
			case CONTADOR2 is 
				when 0 =>				
					RAM_ADDR_IN := conv_integer(DIN);
					CONTADOR2 <= 1;
					leds_procesos <= "1000";
				when 1 =>
					DOUT1 <= E(RAM_ADDR_IN);
					DOUT2 <= V(RAM_ADDR_IN);
					DOUT3 <= A(RAM_ADDR_IN);
					CONTADOR2 <= 0;
				when others => NULL; 
				end case;
		end if;
	end process;
end architecture RAM_BEHAVIOR;