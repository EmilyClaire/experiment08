LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAT_CPU 
        Port ( IN_PORT : in  STD_LOGIC_VECTOR (7 downto 0);
               RST : in  STD_LOGIC;
               CLK : in  STD_LOGIC;
               INT : in  STD_LOGIC;
               IO_STRB : out  STD_LOGIC;
               OUT_PORT : out  STD_LOGIC_VECTOR (7 downto 0);
               PORT_ID : out  STD_LOGIC_VECTOR (7 downto 0));
    END COMPONENT;

   -- test signals
   signal data_io_strb_exp : std_logic := '0';
   signal data_out_exp    : std_logic_vector(7 downto 0) := x"00";
   signal data_id_exp     : std_logic_vector(7 downto 0) := x"00";
   
   --Inputs
   signal s_IN_PORT :   STD_LOGIC_VECTOR (7 downto 0) :=x"20";
   signal s_RST     :   STD_LOGIC := '0'; 
   signal s_CLK     :   STD_LOGIC;
   signal s_INT     :   STD_LOGIC := '0';

    --Outputs
    signal s_IO_STRB :   STD_LOGIC;
    signal s_OUT_PORT:   STD_LOGIC_VECTOR (7 downto 0);
    signal s_PORT_ID :   STD_LOGIC_VECTOR (7 downto 0);
    
       -- Clock period definitions
    constant CLK_period : time := 10 ns;

   
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: RAT_CPU PORT MAP (
        IN_PORT => s_IN_PORT, 
        RST => s_RST,
        CLK => s_CLK,
        INT => s_INT,
        IO_STRB => s_IO_STRB,
        OUT_PORT => s_OUT_PORT,
        PORT_ID => s_PORT_ID);  

   -- Clock process definitions
   CLK_process :process
        begin
            s_CLK <= '0';
            wait for CLK_period/2;
            s_CLK <= '1';
            wait for CLK_period/2;
    end process;

   -- Stimulus process
   stim_proc: process
   begin 
   
    --Simulation 1:
        --in r10, 0x20
        data_io_strb_exp  <= '0';
        data_out_exp      <= x"00";
        data_id_exp       <= x"20";
        
        wait for 335 ns;        
 
        if not(s_IO_STRB = data_io_strb_exp) then
           report "error with io_strb at t= " & time'image(now)
           severity failure;
        else 
           report "data io_strb at t= " & time'image(now) & " is good"
               severity note;
        end if;
   
        if not(s_out_port = data_out_exp) then
          report "error with out_port at t= " & time'image(now) 
          severity failure;
        else 
          report "data out_port at t= " & time'image(now) & " is good"
              severity note;
        end if;

        if not(s_port_Id = data_id_exp) then
          report "error with port_id at t= " & time'image(now) 
          severity failure;
        else 
          report "data port_id at t= " & time'image(now) & " is good"
              severity note;
        end if;     
   
    --Simulation 1:
        --in r10, 0x20
        data_io_strb_exp  <= '0';
        data_out_exp      <= x"00";
        data_id_exp       <= x"FF";
        
        wait for 20 ns;        
 
        if not(s_IO_STRB = data_io_strb_exp) then
           report "error with io_strb at t= " & time'image(now)
           severity failure;
        else 
           report "data io_strb at t= " & time'image(now) & " is good"
               severity note;
        end if;
   
        if not(s_out_port = data_out_exp) then
          report "error with out_port at t= " & time'image(now) 
          severity failure;
        else 
          report "data out_port at t= " & time'image(now) & " is good"
              severity note;
        end if;

        if not(s_port_Id = data_id_exp) then
          report "error with port_id at t= " & time'image(now) 
          severity failure;
        else 
          report "data port_id at t= " & time'image(now) & " is good"
              severity note;
        end if;     
      
   end process;
 
END;