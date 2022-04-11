---------------------------------------------------------------------------------------------------------
-- Modulen AND_gate används för att realisera en AND-grind bestående av insignaler A och B samt
-- utsignal X. Sanningstabellen för AND-grinden visas nedan:
--
--	A	B	X
---------------------------------------------------------------------------------------------------------
-- 	0	0	0
-- 	0 	1 	0
-- 	1 	0 	0
-- 	1 	1 	1
--------------------------------------------------------------------------------------------------------
--
-- Entiteten samt arkitekturen beskriver ett byggblock. Tillsammans sägs de utgöra en modul.
-- Notera att i VHDL skrivs kommentarer med två bindestreck på varje rad.
---------------------------------------------------------------------------------------------------------
library IEEE; 		     -- Inkluderar biblioteket IEEE.
use IEEE.std_logic_1164.all; -- Använder hela packetet std_logic_1164 för datatypen std_logic.

---------------------------------------------------------------------------------------------------------
-- Entiteten beskriver byggblockets in- och utsignaler (dess utsida).
---------------------------------------------------------------------------------------------------------
entity AND_gate is
	port
	(
		A, B : in std_logic; 		-- Insignaler A och B.
		X    : out std_logic 		-- Utsignal X.
	);
end entity;

---------------------------------------------------------------------------------------------------------
-- Arkitekturen beskriver modelens beteende (dess insida).
-- Tilldelning till signaler sker via operatorn <=. Variabler tilldelas i stället via operatorn :=.
---------------------------------------------------------------------------------------------------------
architecture Behaviour of AND_gate is 
begin 
	X <= A and B; 				-- Tilldelar A & B till utsignal x.
end architecture; 
