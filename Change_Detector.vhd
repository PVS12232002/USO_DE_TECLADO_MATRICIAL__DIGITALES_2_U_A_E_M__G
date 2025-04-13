library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Change_Detector is
    Port (
        input_vector : in  STD_LOGIC_VECTOR(3 downto 0);  -- Entrada de 4 bits
        LED          : out STD_LOGIC                        -- Salida LED
    );
end Change_Detector;

architecture Behavioral of Change_Detector is

    -- Declaración de un registro para almacenar el valor anterior
    signal previous_value : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

    -- Proceso que detecta el cambio en el vector de entrada
    process(input_vector)
    begin
        -- Si el valor de entrada ha cambiado con respecto al valor anterior
        if input_vector /= previous_value then
            LED <= '1';  -- Enciende el LED
            previous_value <= input_vector;  -- Actualiza el valor almacenado
        else
            LED <= '0';  -- Apaga el LED
        end if;
    end process;

end Behavioral;
