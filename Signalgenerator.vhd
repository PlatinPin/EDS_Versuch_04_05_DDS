library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Signalgenerator is
    generic(
        teiler_m : integer := 2500;
        N : integer := 12
    );
    Port(
        clk_sig : in std_logic;
        rest : in std_logic;
        sel_phasenstep : in std_logic_vector(N-1 downto 0);
        sig_out : out std_logic;
        one_o : out std_logic :='1'
    );
end Signalgenerator;

architecture Behavioral of Signalgenerator is
    component DDS_n
        generic(
            N_m : integer := 12
        );
        Port(
            clk: in std_logic;
            rest: in std_logic;
            sel_phastep: in std_logic_vector(N_m-1 downto 0);
            sig_o: out std_logic_vector(N_m-1 downto 0)
        );
    end component;
    component PDM
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
    end component;
    component Frequenz_Teiler
        generic(
            teiler : integer :=2
        );
        Port(
            clk_in : in std_logic;
            enable : in std_logic;
            clK_out : out std_logic
        );
    end component;
    signal internal_clk_40k : std_logic;
    signal internal_sig : std_logic_vector(N-1 downto 0);
begin
    
    Freq0: Frequenz_Teiler generic map(teiler_m) port map(clk_in=>clk_sig,enable=>'1',clk_out=>internal_clk_40k);
    DDS0: DDS_n generic map(N) port map(clk=>internal_clk_40k,rest=>rest,sel_phastep=>sel_phasenstep,sig_o=>internal_sig);
    PDM0: PDM generic map(N) port map(clk_pdm=>clk_sig,compsig=>internal_sig,PDM_out=>sig_out);

    one_o <= '1';

end Behavioral;
