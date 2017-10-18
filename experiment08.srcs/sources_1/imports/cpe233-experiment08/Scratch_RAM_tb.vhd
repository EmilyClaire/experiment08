LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY ScratchRAMTestBench IS
END ScratchRAMTestBench;
 
ARCHITECTURE behavior OF ScratchRAMTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ScratchRAM
    PORT(
               DATA_IN  : in     STD_LOGIC_VECTOR (9 downto 0);
               ADR      : in     STD_LOGIC_VECTOR (7 downto 0);
               WE       : in     STD_LOGIC;
               CLK      : in     STD_LOGIC;
               DATA_OUT : out    STD_LOGIC_VECTOR (9 downto 0));
    END COMPONENT;
   -- test signals
   
	signal data_exp : std_logic_vector(9 downto 0) := "0000000000";
	--signal data_y_exp : std_logic_vector(7 downto 0) := x"00";
	

   --Inputs
   signal DATA_IN_tb : std_logic_vector(9 downto 0) := (others => '0');
   --signal DATA_OUT_tb : std_logic_vector(9 downto 0) := (others => '0');
   signal ADR_tb : std_logic_vector(7 downto 0) := (others => '0');
   signal WE_tb : std_logic := '0';
   signal CLK_tb : std_logic := '0';

 	--Outputs
   signal DATA_OUT_tb : std_logic_vector(9 downto 0);
   --signal DY_OUT_tb : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ScratchRAM PORT MAP (
              DATA_IN  => DATA_IN_tb,
              ADR      => ADR_tb,
              WE       => WE_tb,
              CLK      => CLK_tb,
              DATA_OUT => DATA_OUT_tb
              );
          

   -- Clock process definitions
   CLK_process :process
   begin
		CLK_tb <= '0';
		wait for CLK_period/2;
		CLK_tb <= '1';
		wait for CLK_period/2;
   end process;
	

	-- verify memory
	VERIFY_process :process
	variable I : integer range 0 to 255 := 0;

	begin
		--Write to RegisterFile
		ADR_tb<="00000000";
		DATA_IN_tb<="0000000000";
		wait for 4ns;
		WE_tb <= '1'; --toggle high before rising edge
		wait for 1ns;
		while( I < 128) loop
			wait for 1ns;
			WE_tb <= '0'; --drop after rising edge
			wait for 1ns;
			ADR_tb <= ADR_tb + 1; --prepare next address and data
			wait for 1ns;
			DATA_IN_tb <= DATA_IN_tb +2;
			wait for 6ns;
			I := I+1;
			if(I <128) then
				WE_tb <= '1';
			end if;
			wait for 1ns;
		end loop;
		
		WE_tb <= '0';
		--DX_OE_tb <= '1';
		wait for 75ns; --no reason, just like to start at a nice number such as 400ns...
		
		-- Read from RegisterFile
		I := 0;
		-- set initial values
		data_exp <= "0000000000";
		--data_y_exp <= "00000010";
		ADR_tb <= "00000000";
		--ADRY_tb <= "00001";
		-- loop through all memory locations. NOTE: can read two at once
		while ( I < 16) loop
			WE_tb <= '0';
			wait for 1ns;

			--if not(Data_OUT_tb = data_exp) then
				--report "error with data X at t= " & time'image(now) 
				--severity failure;
			--else 
				report "data X at t= " & time'image(now) & " is good"
					severity note;
			--end if;
		
--			if not(DY_OUT_tb = data_y_exp) then
--				report "error with data Y at t= " & time'image(now) 
--				severity failure;
--			else 
--				report "data Y at t= " & time'image(now) & " is good"
--					severity note;
--			end if;	
			wait for 1ns;	
			--get new values
			data_exp <= data_exp + 4 ; --add 4 because each location increases by 2, and you're increasing by 2 memory locations
			--data_y_exp <= data_y_exp + 4 ;
			ADR_tb <= ADR_tb + 2;
			--ADRY_tb <= ADRY_tb + 2;
			
			wait for 8ns;
			I := I + 1; 
		end loop;
		
		wait for 40ns; -- again, just lining up for a nice start time of 600ns.
		
		-- Test OE pin of RegisterFile
		--DX_OE_tb <= '0';
--		wait for 50ns;
--		if not (DATA_OUT_tb = "ZZZZZZZZZZ") then 
--			report "error with OE pin"
--			severity failure;
--		else
--			report "OE pin test 1 passed"
--			severity note;
--		end if;
		--DX_OE_tb <= '1';
		wait for 50ns;
			if (DATA_OUT_tb = "ZZZZZZZZZZ") then 
			report "error with OE pin"
			severity failure;
		else
			report "OE pin test 2 passed"
			severity note;
		end if;
		report "Error checking complete at 700ns" severity note;
		
	end process VERIFY_process;
	

END;
