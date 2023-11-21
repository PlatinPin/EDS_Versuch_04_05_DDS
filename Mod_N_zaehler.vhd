library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity Mod_N_zaehler is
    generic(
        N : integer := 12
    );
    Port(
        clk_in : in std_logic;
        rest_in : in std_logic;
        sel_pahsestep : in std_logic_vector(N-1 downto 0);
        ph_o : out std_logic_vector(N-1 downto 0)
    );
end Mod_N_zaehler;

architecture Behavioral of Mod_N_zaehler is
    type state is (start,rest);
    signal current_state : state := start;
    signal count_std : std_logic_vector(N-1 downto 0) := (others=>'0');
    signal step_int : integer;
    signal count_int : integer;
    signal max_numb : std_logic_vector(N-1 downto 0) := (others=>'1');
begin
    process(rest_in, sel_pahsestep)
        begin
            if(rest_in='1') then
                current_state <= rest;
            else
                current_state <= start;
            end if;
    end process;
    
    process(clk_in)
        begin
            if(rising_edge(clk_in)) then
                case(current_state)is 
                    when rest =>
                        count_std <= (others=>'0');
                  when start =>
                    --count_int <= TO_INTEGER(unsigned(count_std));
                    --step_int <= TO_INTEGER(unsigned(sel_pahsestep));    
                    if(TO_INTEGER(unsigned(count_std)) + TO_INTEGER(unsigned(sel_pahsestep))) >= TO_INTEGER(unsigned(max_numb)) then
                        count_std <= (others =>'0');
                    else
                        --count_int <= count_int + step_int;
                        count_std <= std_logic_vector(unsigned(count_std) + unsigned(sel_pahsestep)); 
                    end if;
                 when others =>
                    count_std <= (others=>'0');
               end case;
            end if;
    end process;
ph_o <= count_std;
end Behavioral;