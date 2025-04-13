library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AntiRebote is
    Port ( clk_25mhz : in STD_LOGIC;  -- Reloj de 25 MHz
           btn : in STD_LOGIC;        -- Botón de entrada
           out_signal : out STD_LOGIC  -- Señal de salida
           );
end AntiRebote;

architecture Behavioral of AntiRebote is
    -- Señales internas
    signal cnt : STD_LOGIC_VECTOR(24 downto 0);  -- Contador de 25 bits (para contar hasta 25M)
    signal btn_reg : STD_LOGIC;                    -- Registro del botón (para detectar flancos)
    signal btn_sync : STD_LOGIC;                   -- Sincronización del botón
    signal out_signal_reg : STD_LOGIC;             -- Registro de la señal de salida
    signal btn_pressed : STD_LOGIC;                -- Indicador de si el botón está presionado

begin

    -- Proceso de sincronización del botón con el reloj de 25MHz
    process(clk_25mhz)
    begin
        if rising_edge(clk_25mhz) then
            btn_sync <= btn;  -- Sincroniza la señal del botón
            btn_reg <= btn_sync;  -- Registra el valor sincronizado
        end if;
    end process;

    -- Proceso para detectar el flanco ascendente del botón (cuando se presiona)
    process(clk_25mhz)
    begin
        if rising_edge(clk_25mhz) then
            if btn_sync = '1' and btn_reg = '0' then
                btn_pressed <= '1';  -- Detecta el flanco ascendente
            else
                btn_pressed <= '0';
            end if;
        end if;
    end process;

    -- Contador para generar un pulso de salida de medio segundo (500ms)
    process(clk_25mhz)
    begin
        if rising_edge(clk_25mhz) then
            if btn_pressed = '1' then
                -- Si el botón fue presionado, reinicia el contador y mantiene el '1' durante 500ms
                cnt <= (others => '0');
                out_signal_reg <= '1';
            else
                if cnt = "1100000000000000000000000" then  -- 25 MHz * 500 ms = 12,500,000 ciclos
                    out_signal_reg <= '0';  -- Después de 500ms, baja la salida
                else
                    cnt <= cnt + 1;  -- Incrementa el contador
                end if;
            end if;
        end if;
    end process;

    -- Salida final
    out_signal <= out_signal_reg;

end Behavioral;
