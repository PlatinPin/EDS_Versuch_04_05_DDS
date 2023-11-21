library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PDM is
    generic(
        N_pdm: integer := 12
    );
    Port(
        clk_pdm : in std_logic;
        --ACC_in : in std_logic_vector(N_pdm-1 downto 0);
        compsig: in std_logic_vector(N_pdm-1 downto 0);
        ph_pdm: out std_logic_vector(N_pdm-1 downto 0);
        PDM_out : out std_logic
    );
end PDM;

architecture Behavioral of PDM is
    component Mod_N_zaehler
        generic(
            N : integer := 4
        );
        Port(
            clk_in : in std_logic;
            rest_in : in std_logic;
            sel_pahsestep : in std_logic_vector(N-1 downto 0);
            ph_o : out std_logic_vector(N-1 downto 0)
        );
    end component;
    signal internal_ph : std_logic_vector(N_pdm-1 downto 0);
begin

    Phas0: Mod_N_zaehler generic map(N_pdm) port map(clk_in=>clk_pdm,rest_in=>'0',sel_pahsestep=>"000000000100",ph_o=>internal_ph);
    
    
    process(internal_ph,compsig)
        begin
                if (unsigned(internal_ph) > unsigned(compsig)) then
                    PDM_out <= '1';
                else
                    PDM_out <= '0';
                end if;
    end process;
   
ph_pdm <= internal_ph;

end Behavioral;
