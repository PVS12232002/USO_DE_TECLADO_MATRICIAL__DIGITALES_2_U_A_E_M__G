library IEEE;
use ieee.std_logic_1164.all;
--Andres Uriel Diaz Hidalgo 
entity Teclado is
    port (
        Reloj: in std_logic;
        col: in std_logic_vector(3 downto 0);
        filas: out std_logic_vector(3 downto 0);
        display: out std_logic;
        segmentos: out std_logic_vector(6 downto 0)
    );
end Teclado;

architecture TecladoMatricial of Teclado is
    component LIB_TEC_MATRICIAL_4x4_INTESC_RevA is
        generic (
            FREQ_CLK: INTEGER := 50_000_000 -- FRECUENCIA DE LA TARJETA
        );
        port (
            CLK: IN STD_LOGIC; -- RELOJ FPGA
            COLUMNAS: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- PUERTO CONECTADO A LAS COLUMNAS DEL TECLADO
            FILAS: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- PUERTO CONECTADO A LA FILAS DEL TECLADO
            BOTON_PRES: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- PUERTO QUE INDICA LA TECLA QUE SE PRESIONÓ
            IND: OUT STD_LOGIC -- BANDERA QUE INDICA CUANDO SE PRESIONÓ UNA TECLA (SÓLO DURA UN CICLO DE RELOJ)
        );
    end component LIB_TEC_MATRICIAL_4x4_INTESC_RevA;

    signal boton_press: std_logic_vector(3 downto 0) := (others => '0'); -- Cambiado a 4 bits
    signal ind: std_logic := '0';
    signal segm: std_logic_vector(6 downto 0) := "1111111";

begin
    libreria: LIB_TEC_MATRICIAL_4x4_INTESC_RevA
        generic map (FREQ_CLK => 50000000)
        port map (Reloj, col, filas, boton_press, ind);

    Proceso_Teclado: process(Reloj)
    begin
        if rising_edge(Reloj) then
            if ind = '1' then
                case boton_press is
                    when x"0" => segm <= "1000000"; -- 0
                    when x"1" => segm <= "1111001"; -- 1
                    when x"2" => segm <= "0100100"; -- 2
                    when x"3" => segm <= "0110000"; -- 3
                    when x"4" => segm <= "0011001"; -- 4
                    when x"5" => segm <= "0010010"; -- 5
                    when x"6" => segm <= "0000010"; -- 6
                    when x"7" => segm <= "1111000"; -- 7
                    when x"8" => segm <= "0000000"; -- 8
                    when x"9" => segm <= "0011000"; -- 9
                    when x"A" => segm <= "0001000"; -- A
                    when x"B" => segm <= "0000011"; -- B
                    when x"C" => segm <= "1000110"; -- C
                    when x"D" => segm <= "0100001"; -- D
                    when x"E" => segm <= "0000110"; -- E
                    when x"F" => segm <= "0001110"; -- F
                    when others => segm <= segm; -- Sin cambio
                end case;
            end if;
        end if;
    end process;

    display <= '0';
    segmentos <= segm;

end TecladoMatricial;
