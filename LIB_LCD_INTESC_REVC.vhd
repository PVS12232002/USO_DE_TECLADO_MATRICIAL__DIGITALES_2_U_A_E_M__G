library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
USE WORK.COMANDOS_LCD_REVC.ALL;

entity LIB_LCD_INTESC_REVC is


PORT(CLK: IN STD_LOGIC;

-------------------------------------------------------
-------------PUERTOS DE LA LCD (NO BORRAR)-------------
	  RS : OUT STD_LOGIC;									  --
	  RW : OUT STD_LOGIC;									  --
	  ENA : OUT STD_LOGIC;									  --
	  CORD : IN STD_LOGIC;									  --
	  CORI : IN STD_LOGIC;									  --
	  DATA_LCD: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);     --
	  BLCD :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0);        --
-------------------------------------------------------
	  
-----------------------------------------------------------
--------------ABAJO ESCRIBE TUS PUERTOS--------------------	
	DATO : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	DATO1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	DATO2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	  );



end LIB_LCD_INTESC_REVC;

architecture Behavioral of LIB_LCD_INTESC_REVC is

-----------------------------------------------------------------
---------------SE�ALES DE LA LCD (NO BORRAR)---------------------
TYPE RAM IS ARRAY (0 TO  60) OF STD_LOGIC_VECTOR(8 DOWNTO 0);  --
																					--
SIGNAL INST : RAM;													--
																					--
COMPONENT PROCESADOR_LCD_REVC is											--
																					--
PORT(CLK : IN STD_LOGIC;													--
	  VECTOR_MEM : IN STD_LOGIC_VECTOR(8 DOWNTO 0);					--
	  INC_DIR : OUT INTEGER RANGE 0 TO 1024;							--
	  CORD : IN STD_LOGIC;													--
	  CORI : IN STD_LOGIC;													--
	  RS : OUT STD_LOGIC;													--
	  RW : OUT STD_LOGIC;													--
	  DELAY_COR : IN INTEGER RANGE 0 TO 1000;							--
	  BD_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);			         --
	  ENA  : OUT STD_LOGIC;													--
	  C1A,C2A,C3A,C4A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       --
	  C5A,C6A,C7A,C8A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);       --
	  DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)							--
		);																			--
																					--
end  COMPONENT PROCESADOR_LCD_REVC;										--
																					--
COMPONENT CARACTERES_ESPECIALES_REVC is										--
																					--
PORT( C1,C2,C3,C4:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);				--
		C5,C6,C7,C8:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);				--
		CLK : IN STD_LOGIC													--
		);																			--
																					--
end COMPONENT CARACTERES_ESPECIALES_REVC;	

             								--


                  							--

																					--
CONSTANT CHAR1 : INTEGER := 1;											--
CONSTANT CHAR2 : INTEGER := 2;											--
CONSTANT CHAR3 : INTEGER := 3;											--
CONSTANT CHAR4 : INTEGER := 4;											--
CONSTANT CHAR5 : INTEGER := 5;											--
CONSTANT CHAR6 : INTEGER := 6;											--
CONSTANT CHAR7 : INTEGER := 7;											--
CONSTANT CHAR8 : INTEGER := 8;											--
																					--
																					--
SIGNAL DIR : INTEGER RANGE 0 TO 1024 := 0;							--
SIGNAL VECTOR_MEM_S : STD_LOGIC_VECTOR(8 DOWNTO 0);				--
SIGNAL RS_S, RW_S, E_S : STD_LOGIC;										--
SIGNAL DATA_S : STD_LOGIC_VECTOR(7 DOWNTO 0);						--
SIGNAL DIR_S : INTEGER RANGE 0 TO 1024;								--
SIGNAL DELAY_COR : INTEGER RANGE 0 TO 1000;							--
SIGNAL C1S,C2S,C3S,C4S : STD_LOGIC_VECTOR(39 DOWNTO 0);	      --
SIGNAL C5S,C6S,C7S,C8S : STD_LOGIC_VECTOR(39 DOWNTO 0);  	   --
----------------------------------------------------------------



---------------------------------------------------------
--------------AGREGA TUS SE�ALES AQU�--------------------

---------------------------------------------------------

BEGIN


-----------------------------------------------------------
------------COMPONENTES PARA LCD (NO BORRAR)---------------
U1 : PROCESADOR_LCD_REVC PORT MAP(CLK  => CLK,				--
									 VECTOR_MEM => VECTOR_MEM_S,	--
									 RS  => RS_S,						--
									 RW  => RW_S,						--
									 ENA => E_S,						--
									 INC_DIR => DIR_S,				--
									 DELAY_COR => DELAY_COR,		--
									 BD_LCD => BLCD,					--
									 CORD => CORD,						--
									 CORI => CORI,						--
									 C1A =>C1S,  					   --	
									 C2A =>C2S,							--
									 C3A =>C3S,							--
									 C4A =>C4S,							--
									 C5A =>C5S,							--
									 C6A =>C6S,							--
									 C7A =>C7S,							--
									 C8A =>C8S,							--
									 DATA  => DATA_S );				--
																			--
U2 : CARACTERES_ESPECIALES_REVC PORT MAP(C1 =>C1S,			--	
									C2 =>C2S,							--
									C3 =>C3S,							--
									C4 =>C4S,							--
									C5 =>C5S,							--
									C6 =>C6S,							--
									C7 =>C7S,						   --
									C8 =>C8S,							--
									CLK => CLK							--
									);										--
																			--
DIR <= DIR_S;															--
VECTOR_MEM_S <= INST(DIR);								--
																			--
RS <= RS_S;																--
RW <= RW_S;																--
ENA <= E_S;																--
DATA_LCD <= DATA_S;

																			--
													                  --
-----------------------------------------------------------


DELAY_COR <= 600; --Modificar esta variable para la velocidad del corrimiento.

-------------------------------------------------------------------
-----------------ABAJO ESCRIBE TU C�DIGO EN VHDL-------------------
process(clk)
begin
INST(0)  <= LCD_INI("11");
INST(1) <= POS(2,1);
INST(2) <= BUCLE_INI(1);
IF DATO = "0000" THEN
INST(3) <= INT_NUM(0);
ELSIF DATO = "0001" THEN
INST(3) <= INT_NUM(1);
ELSIF DATO = "0010" THEN
INST(3) <= INT_NUM(2);
ELSIF DATO = "0011" THEN
INST(3) <= INT_NUM(3);
ELSIF DATO = "0100" THEN
INST(3) <= INT_NUM(4);
ELSIF DATO = "0101" THEN
INST(3) <= INT_NUM(5);
ELSIF DATO = "0110" THEN
INST(3) <= INT_NUM(6);
ELSIF DATO = "0111" THEN
INST(3) <= INT_NUM(7);
ELSIF DATO = "1000" THEN
INST(3) <= INT_NUM(8);
ELSIF DATO = "1001" THEN
INST(3) <= INT_NUM(9);
ELSIF DATO = "1010" THEN
INST(3)  <= CHAR_ASCII(X"65");
ELSIF DATO = "1011" THEN
INST(3)  <= CHAR_ASCII(X"66");
ELSIF DATO = "1100" THEN
INST(3)  <= CHAR_ASCII(X"67");
ELSIF DATO = "1101" THEN
INST(3)  <= CHAR_ASCII(X"68");
ELSIF DATO = "1110" THEN
INST(3)  <= CHAR_ASCII(X"69");
ELSIF DATO = "1111" THEN
INST(3)  <= CHAR_ASCII(X"70");
END IF;

IF DATO1 = "0000" THEN
INST(4) <= INT_NUM(0);
ELSIF DATO1 = "0001" THEN
INST(4) <= INT_NUM(1);
ELSIF DATO1 = "0010" THEN
INST(4) <= INT_NUM(2);
ELSIF DATO1 = "0011" THEN
INST(4) <= INT_NUM(3);
ELSIF DATO1 = "0100" THEN
INST(4) <= INT_NUM(4);
ELSIF DATO1 = "0101" THEN
INST(4) <= INT_NUM(5);
ELSIF DATO1 = "0110" THEN
INST(4) <= INT_NUM(6);
ELSIF DATO1 = "0111" THEN
INST(4) <= INT_NUM(7);
ELSIF DATO1 = "1000" THEN
INST(4) <= INT_NUM(8);
ELSIF DATO1 = "1001" THEN
INST(4) <= INT_NUM(9);
ELSIF DATO1 = "1010" THEN
INST(4)  <= CHAR_ASCII(X"65");
ELSIF DATO1 = "1011" THEN
INST(4)  <= CHAR_ASCII(X"66");
ELSIF DATO1 = "1100" THEN
INST(4)  <= CHAR_ASCII(X"67");
ELSIF DATO1 = "1101" THEN
INST(4)  <= CHAR_ASCII(X"68");
ELSIF DATO1 = "1110" THEN
INST(4)  <= CHAR_ASCII(X"69");
ELSIF DATO1 = "1111" THEN
INST(4)  <= CHAR_ASCII(X"70");
END IF;

IF DATO2 = "0000" THEN
INST(5) <= INT_NUM(0);
ELSIF DATO2 = "0001" THEN
INST(5) <= INT_NUM(1);
ELSIF DATO2 = "0010" THEN
INST(5) <= INT_NUM(2);
ELSIF DATO2 = "0011" THEN
INST(5) <= INT_NUM(3);
ELSIF DATO2 = "0100" THEN
INST(5) <= INT_NUM(4);
ELSIF DATO2 = "0101" THEN
INST(5) <= INT_NUM(5);
ELSIF DATO2 = "0110" THEN
INST(5) <= INT_NUM(6);
ELSIF DATO2 = "0111" THEN
INST(5) <= INT_NUM(7);
ELSIF DATO2 = "1000" THEN
INST(5) <= INT_NUM(8);
ELSIF DATO2 = "1001" THEN
INST(5) <= INT_NUM(9);
ELSIF DATO2 = "1010" THEN
INST(5)  <= CHAR_ASCII(X"65");
ELSIF DATO2 = "1011" THEN
INST(5)  <= CHAR_ASCII(X"66");
ELSIF DATO2 = "1100" THEN
INST(5)  <= CHAR_ASCII(X"67");
ELSIF DATO2 = "1101" THEN
INST(5)  <= CHAR_ASCII(X"68");
ELSIF DATO2 = "1110" THEN
INST(5)  <= CHAR_ASCII(X"69");
ELSIF DATO2 = "1111" THEN
INST(5)  <= CHAR_ASCII(X"70");
END IF;
INST(6)  <= CHAR_ASCII(X"20");
INST(7) <= BUCLE_FIN(1);
INST(8)  <= CHAR_ASCII(X"20");
INST(9) <= CODIGO_FIN(1);
end process;
end Behavioral;