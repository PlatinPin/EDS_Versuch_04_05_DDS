library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DDS_n is
    generic(
        N_m : integer := 12
    );
    Port(
        clk: in std_logic;
        rest: in std_logic;
        sel_phastep: in std_logic_vector(N_m-1 downto 0);
        sig_o: out std_logic_vector(N_m-1 downto 0)
    );
end DDS_n;

architecture Behavioral of DDS_n is
    component Mod_N_zaehler
        generic(
            N : integer := 16
        );
        Port(
            clk_in : in std_logic;
            rest_in : in std_logic;
            sel_pahsestep : in std_logic_vector(N-1 downto 0);
            ph_o : out std_logic_vector(N-1 downto 0)
        );
    end component;
    component blk_mem_gen_0
        Port(
            clka : IN STD_LOGIC;
            ena : IN STD_LOGIC;
            wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    end component;
    signal internal_add: std_logic_vector(N_m-1 downto 0);
begin

    PHA0: Mod_N_zaehler generic map(N_m) port map(clk_in=>clk,rest_in=>rest,sel_pahsestep=>sel_phastep,ph_o=>internal_add);
    ROM0: blk_mem_gen_0 port map(clka=>clk,ena=>'1',wea=>"0",addra=>internal_add,dina=>"000000000000",douta=>sig_o);






end Behavioral;
