library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AntiRebote is
    Port ( clk      : in  STD_LOGIC;  -- Reloj (clk)
           rst      : in  STD_LOGIC;  -- Reset (asíncrono)
           pb_in    : in  STD_LOGIC;  -- Entrada del pulsador
           pb_out   : out STD_LOGIC   -- Salida filtrada del pulsador
           );
end AntiRebote;

architecture Behavioral of AntiRebote is

    -- Señal interna para almacenar el estado filtrado
    signal pb_reg      : STD_LOGIC := '0';  -- Registra la señal de entrada
    signal pb_stable   : STD_LOGIC := '0';  -- Estado estable del pulsador
    signal counter     : integer := 0;       -- Contador de tiempo

    constant COUNTER_LIMIT : integer := 2000000; -- Límite del contador (~20ms si clk es de 100MHz)

begin

    -- Proceso que maneja el filtrado y el rebote
    process(clk, rst)
    begin
        if rst = '1' then
            pb_reg <= '0';
            pb_stable <= '0';
            counter <= 0;
        elsif rising_edge(clk) then
            -- Control del contador
            if counter = COUNTER_LIMIT then
                -- Si el contador llega al límite, se actualiza el estado del pulsador
                if pb_in = pb_reg then
                    pb_stable <= pb_in;  -- El estado del pulsador se estabiliza
                end if;
                counter <= 0;  -- Reseteamos el contador
            else
                counter <= counter + 1;  -- Incrementamos el contador
            end if;
            
            -- Almacena el valor actual del pulsador
            pb_reg <= pb_in;
        end if;
    end process;

    -- La salida es el estado estable del pulsador
    pb_out <= pb_stable;

end Behavioral;
