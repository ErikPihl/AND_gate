---------------------------------------------------------------------------------------------------------
-- Modulen AND_gate_TB används som testbänk till toppmodulen AND_gate för att simulera dess 
-- funktion via ModelSim. Signaler med samma namn som toppmodulens in- och utportar deklareras och 
-- kopplas till toppmodulen. I den deklarativa delen av arkitekturen (innan begin) deklareras signaler, 
-- komponenter och dylikt. I definitionsdelen av arkitekturen (efter begin) sker sammankoppling samt
-- tilldelning till simulerade insignaler.
--
-- Simulering sker under 40 ns enligt nedan, där A och B utgör simulerade insignaler och
-- X utgör förväntad utsignal:
--
-- Tid (ns)  A  B  X   
----------------------------------------------------------------------------------------------
--   10      0  0  0          
--   20      0  1  0      
--   30      1  0  0     
--   40      1  1  1    
----------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
library IEEE; 			-- Inkluderar biblioteket IEEE.
use IEEE.std_logic_1164.all; 	-- Inkluderar specifikt paketet std_logic_1164 från biblioteket IEEE.

entity AND_gate_TB is
end entity; 

architecture Testbench of AND_gate_TB is

signal A, B, X : std_logic; 	-- Simulerar in- och utsignaler med samma namn i toppmodulen.

---------------------------------------------------------------------------------------------------------
-- Komponenten AND_gate deklareras för att kunna skapa en instans / ett objekt av toppmodulen för
-- simulering. Efter denna deklaration kan dess in- och utsignaler sammankopplas med signaler med
-- samma namn i denna modul. Notera att komponentsdeklarationen är identisk med entitetsdeklarationen,
-- med skillnaden att nyckelordet entity har ersatts med component.
---------------------------------------------------------------------------------------------------------
component AND_gate is
	port
	(
		A, B : in std_logic; -- Insignaler A och B.
		X    : out std_logic -- Utsignal X.
	);
end component;

begin

	-------------------------------------------------------------------------------------
	-- Här sammankopplas in- och utportar från toppmodulen med signaler i denna testbänk
	-- med samma namn via så kallad port mapping. Vi skapar en instans av toppmodulen
	-- AND_gate, som döps till AND_gate1. Som exempel, för att sammankoppla inporten A 
	-- till signalen A i testbänken skriver vi A => A.
	-------------------------------------------------------------------------------------
	AND_gate1: AND_gate port map
	(
		A => A,
		B => B,
		X => X
	);
	
	-------------------------------------------------------------------------------------
	-- Denna process används för att tilldela låg signal till inport A under 20 ns,
	-- följt av hög signal under 20 ns. Notera att apostrofer används för tilldelning
	-- av enskilda bitar, såsom '1' för en hög bit och '0' för en låg bit. För multipla 
	-- bitar, som vi kommer se senare, används i stället citattecken, exempelvis "1111" 
	-- för den 4-bitars binära motsvarigheten till heltalet 15. Direktivet wait används
	-- för att fördröja programmet en viss till eller kontinuerligt. Detta direktiv
	-- är inte syntetiserbart, utan kan enbart användas för simulering.
	-------------------------------------------------------------------------------------
	A_PROCESS: process is
	begin
		A <= '0'; 			-- Tilldelar låg signal till A.
		wait for 20 ns; 		-- Fördröjer aktuellt tillstånd i 20 ns.
		A <= '1'; 			-- Tilldelar hög signal till A.
		wait for 20 ns;			-- Fördröjer aktuellt tillstånd i 20 ns.
		wait; 				-- Håller tillståndet resten av simuleringen.
	end process;
	
	-------------------------------------------------------------------------------------
	-- Denna process används för att toggla signal B var 10:e ns fyra gånger. I detta
	-- fall används för en for-sats, som itererar två gånger. Under varje varv togglas
	-- signal B från låg till hög var 10:e ns.
	-------------------------------------------------------------------------------------
	B_PROCESS: process is
	begin
		for i in 0 to 1 loop 		-- Itererar två varv.
			B <= '0'; 		-- Tilldelar låg signal till B.
			wait for 10 ns; 	-- Fördröjer aktuellt tillstånd i 10 ns.
			B <= '1'; 		-- Tilldelar hög signal till B.
			wait for 10 ns; 	-- Fördröjer aktuellt tillstånd i 10 ns.
		end loop; 			-- Här slutar for-loopen.
		wait; 				-- Håller tillståndet resten av simuleringen.
	end process;

end architecture;
