library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decoder_7Seg_to_Bin is
    Port (
        segm        : in  STD_LOGIC_VECTOR(6 downto 0);  -- Entrada de los 7 segmentos en binario
        boton_press : out STD_LOGIC_VECTOR(3 downto 0)   -- Salida como valor binario (hexadecimal)
    );
end Decoder_7Seg_to_Bin;

architecture Behavioral of Decoder_7Seg_to_Bin is
begin
    process(segm)
    begin
        case segm is
            when "1000000" => boton_press <= "0000"; -- 0
            when "1111001" => boton_press <= "0001"; -- 1
            when "0100100" => boton_press <= "0010"; -- 2
            when "0110000" => boton_press <= "0011"; -- 3
            when "0011001" => boton_press <= "0100"; -- 4
            when "0010010" => boton_press <= "0101"; -- 5
            when "0000010" => boton_press <= "0110"; -- 6
            when "1111000" => boton_press <= "0111"; -- 7
            when "0000000" => boton_press <= "1000"; -- 8
            when "0011000" => boton_press <= "1001"; -- 9
            when "0001000" => boton_press <= "1010"; -- A
            when "0000011" => boton_press <= "1011"; -- B
            when "1000110" => boton_press <= "1100"; -- C
            when "0100001" => boton_press <= "1101"; -- D
            when "0000110" => boton_press <= "1110"; -- E
            when "0001110" => boton_press <= "1111"; -- F
            when others => boton_press <= "ZZZZ"; -- Si no se reconoce el valor
        end case;
    end process;
end Behavioral;