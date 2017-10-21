----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2017 05:40:28 PM
-- Design Name: 
-- Module Name: ALU_MUX - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SCR_MUX is
  Port (SY          : in std_logic_vector(7 downto 0);
        IR          : in std_logic_vector(7 downto 0);
        SP_OUT      : in std_logic_vector(7 downto 0);
        SP_OUT_DECR : in std_logic_vector(7 downto 0);
        SCR_ADDR_SEL : in std_logic_vector (1 downto 0);
        SCR_Output : out std_logic_vector (7 downto 0));
end SCR_MUX;

architecture Behavioral of SCR_MUX is

begin 
process(SY, IR, SP_OUT, SP_OUT_DECR, SCR_ADDR_SEL)
variable temp_SCR : std_logic_vector(7 downto 0) := x"00";
Begin

    if(SCR_ADDR_SEL = "00")then
        temp_SCR := SY;
    elsif(SCR_ADDR_SEL = "01")then
        temp_SCR := IR;
    elsif(SCR_ADDR_SEL = "10") then
        temp_SCR := SP_OUT;
    else
        temp_SCR := SP_OUT_DECR;
    end if;
    
SCR_Output <= temp_SCR; 
end process;


end Behavioral;