library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity teclado is
	port(
		clk: in std_logic;
		c: in std_logic_vector(3 downto 0); --columnas
		f: out std_logic_vector(3 downto 0); --filas
		ram: out std_logic_vector(3 downto 0)
	);
end teclado;

architecture sd2 of teclado is
	component div_frecuencia
		port( 
		clk: in std_logic;
		n_ciclos: in integer;
		f: out std_logic
		);
	end component;
	
	component antirebote
		port(
			clk, btn: in std_logic;
			bto: out std_logic
		);
	end component;
	
	--señales para registro de desplazamiento y antirebote
	signal fr, far, b: std_logic; --frecuencias reducidas y bandera de guardado
	signal reg: std_logic_vector(3 downto 0) := "0001"; --registro de fila y barrido del teclado
	signal bcd, cl: std_logic_vector(3 downto 0); --número bcd y columna limpia
	signal col_fil: std_logic_vector(7 downto 0); --señal de guardado de columna y fila
		
begin
	
	--prepocesamieto donde se hacen instancias de las señales anteriores
	df1: div_frecuencia port map(clk,10000,far);
	df2: div_frecuencia port map(clk,125000,fr);
	
	ar: for i in 0 to 3 generate
		antr: antirebote port map(far,c(i),cl(i)); --salidas de antirrebote
	end generate;
	
process(fr, b)
	begin
		
		--registro de desplazamiento
		if rising_edge(fr) then
			reg <= reg(0) & reg(3 downto 1); --salida de flip-flop que se conecta al siguiente flip-flop
		end if;
		
		--memoria
		b <= cl(0) or cl(1) or cl(2) or cl(3); --pulsos de alguna entrada
		
		if rising_edge(b) then
			col_fil <= c & reg; --guarda combinación de entrada en el momento del barrido cuando b es 1/ concatena un pulso con el registro
		end if;
end process;

	ram <= bcd;
	f <= reg;
end sd2;