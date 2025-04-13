library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;  

-- Declaración de la entidad MEMORIA
entity MEMORIA is 
    port ( 
        RELOJ   : in std_logic;                -- Reloj de entrada
        ENTRADA   : in std_logic_vector(3 downto 0); -- Dato de entrada (4 bits)
        LED   : out std_logic_vector(2 DOWNTO 0); -- Indicador de procesos (3 bits)
        SALIDA  : out std_logic_vector(3 downto 0) := "0000";  -- Dato de salida (4 bits), inicializado a "0000"
		  SALIDA1  : out std_logic_vector(3 downto 0) := "0000";  -- Dato de salida (4 bits), inicializado a "0000"
		  SALIDA2  : out std_logic_vector(3 downto 0) := "0000"  -- Dato de salida (4 bits), inicializado a "0000"
    ); 
end entity MEMORIA; 

-- Arquitectura que define el comportamiento de la entidad MEMORIA
architecture VECTORES of MEMORIA is 

    -- Declaración de señales internas que representan una memoria de 16 posiciones de 4 bits
    SIGNAL P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15 : std_logic_vector(3 downto 0) := "0000"; 
	 SIGNAL Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15 : std_logic_vector(3 downto 0) := "0000"; 
	 SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15 : std_logic_vector(3 downto 0) := "0000"; 

    -- Señales internas para el contador, el estado y el selector
    SIGNAL CONTADOR, state, selector : INTEGER := 0; 

begin 
    -- Proceso sensible al flanco de subida del reloj (RELOJ)
    process(RELOJ)  
    begin 
        if rising_edge(RELOJ) then  -- Detecta el flanco de subida del reloj
            case CONTADOR is  -- Dependiendo del valor de CONTADOR, se realiza una acción
                when 0 => 
                    LED <= "000";  -- Indica que el proceso no está en ejecución
                when 1 => 
                    LED <= "001";  -- Indica que el proceso está esperando una entrada
                    -- Determina el valor de "selector" según la entrada (ENTRADA)
                    case ENTRADA is
                        when "0000" => selector <= 0;
                        when "0001" => selector <= 1;
                        when "0010" => selector <= 2;
                        when "0011" => selector <= 3;
                        when "0100" => selector <= 4;
                        when "0101" => selector <= 5;
                        when "0110" => selector <= 6;
                        when "0111" => selector <= 7;
                        when "1000" => selector <= 8;
                        when "1001" => selector <= 9;
                        when "1010" => selector <= 10;
                        when "1011" => selector <= 11;
                        when "1100" => selector <= 12;
                        when "1101" => selector <= 13;
                        when "1110" => selector <= 14;
                        when "1111" => selector <= 15;
                        when others => null;  -- Si no coincide con ninguna, no hace nada
                    end case;
                    CONTADOR <= 2;  -- Cambia el valor del contador a 2 para la siguiente etapa

                when 2 =>  -- En el estado 2 se realiza la lectura o escritura según el valor de "state"
                    if state = 1 then  -- Si el estado es 1, es una operación de lectura
                        LED <= "010";  -- Indica que se está leyendo
                        -- Se asigna el valor de la memoria al puerto SALIDA según el selector
                        case selector is
                            when 0 => SALIDA <= P0;
                            when 1 => SALIDA <= P1;
                            when 2 => SALIDA <= P2;
                            when 3 => SALIDA <= P3;
                            when 4 => SALIDA <= P4;
                            when 5 => SALIDA <= P5;
                            when 6 => SALIDA <= P6;
                            when 7 => SALIDA <= P7;
                            when 8 => SALIDA <= P8;
                            when 9 => SALIDA <= P9;
                            when 10 => SALIDA <= P10;
                            when 11 => SALIDA <= P11;
                            when 12 => SALIDA <= P12;
                            when 13 => SALIDA <= P13;
                            when 14 => SALIDA <= P14;
                            when 15 => SALIDA <= P15;
                            when others => null;
                        end case;
                        state <= 3;  -- Cambia el estado a 4
                    elsif state = 2 then  -- Si el estado es 2, es una operación de escritura
                        LED <= "100";  -- Indica que se está escribiendo
                        -- Se asigna el valor de la ENTRADA a la memoria correspondiente
                        case selector is
                            when 0 => P0 <= ENTRADA;
                            when 1 => P1 <= ENTRADA;
                            when 2 => P2 <= ENTRADA;
                            when 3 => P3 <= ENTRADA;
                            when 4 => P4 <= ENTRADA;
                            when 5 => P5 <= ENTRADA;
                            when 6 => P6 <= ENTRADA;
                            when 7 => P7 <= ENTRADA;
                            when 8 => P8 <= ENTRADA;
                            when 9 => P9 <= ENTRADA;
                            when 10 => P10 <= ENTRADA;
                            when 11 => P11 <= ENTRADA;
                            when 12 => P12 <= ENTRADA;
                            when 13 => P13 <= ENTRADA;
                            when 14 => P14 <= ENTRADA;
                            when 15 => P15 <= ENTRADA;
                            when others => null;
                        end case;
                        state <= 4;  -- Cambia el estado a 3
                    end if;
					 when 4 => 
									 case selector is
                            when 0 => Q0 <= ENTRADA;
                            when 1 => Q1 <= ENTRADA;
                            when 2 => Q2 <= ENTRADA;
                            when 3 => Q3 <= ENTRADA;
                            when 4 => Q4 <= ENTRADA;
                            when 5 => Q5 <= ENTRADA;
                            when 6 => Q6 <= ENTRADA;
                            when 7 => Q7 <= ENTRADA;
                            when 8 => Q8 <= ENTRADA;
                            when 9 => Q9 <= ENTRADA;
                            when 10 => Q10 <= ENTRADA;
                            when 11 => Q11 <= ENTRADA;
                            when 12 => Q12 <= ENTRADA;
                            when 13 => Q13 <= ENTRADA;
                            when 14 => Q14 <= ENTRADA;
                            when 15 => Q15 <= ENTRADA;
									 when others => NULL;
									 end case;
                        state <= 5;  -- Cambia el estado a 3
					 when 5 =>
					             case selector is
                            when 0 => R0 <= ENTRADA;
                            when 1 => R1 <= ENTRADA;
                            when 2 => R2 <= ENTRADA;
                            when 3 => R3 <= ENTRADA;
                            when 4 => R4 <= ENTRADA;
                            when 5 => R5 <= ENTRADA;
                            when 6 => R6 <= ENTRADA;
                            when 7 => R7 <= ENTRADA;
                            when 8 => R8 <= ENTRADA;
                            when 9 => R9 <= ENTRADA;
                            when 10 => R10 <= ENTRADA;
                            when 11 => R11 <= ENTRADA;
                            when 12 => R12 <= ENTRADA;
                            when 13 => R13 <= ENTRADA;
                            when 14 => R14 <= ENTRADA;
                            when 15 => R15 <= ENTRADA;
									 when others => NULL;
									 end case;
                        state <= 3;  -- Cambia el estado a 3
                when others => null;  -- En caso de que el contador tenga otro valor, no realiza ninguna acción
            end case;

            -- Si el estado es 0 (inicial), verifica si la entrada es de lectura o escritura
            if state = 0 then
                if ENTRADA = "1111" then  -- Lectura (código 1111)
                    CONTADOR <= 1;  -- Cambia el contador a 1 para ir al estado de lectura
                    state <= 1;  -- Cambia el estado a 1 (lectura)
                elsif ENTRADA = "1110" then  -- Escritura (código 1110)
                    CONTADOR <= 1;  -- Cambia el contador a 1 para ir al estado de escritura
                    state <= 2;  -- Cambia el estado a 2 (escritura)
                end if;
            end if;

            -- Si el estado es 3 (final de lectura o escritura), reinicia el contador
            if state = 3 then
                CONTADOR <= 0;  -- Reinicia el contador
					 state <=0;
            end if;
        end if;
    end process;
end VECTORES;