library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Frequenz_Teiler is
    generic(
        teiler : integer :=2
    );
    Port(
        clk_in : in std_logic;
        enable : in std_logic;
        clK_out : out std_logic
    );
end Frequenz_Teiler;

architecture Behavioral of Frequenz_Teiler is
    signal counter : integer := 0;
begin
    process(clk_in,enable)
        begin
            if(enable = '0') then
                clk_out <= '0';
            else
                if(rising_edge(clk_in)) then
                    if(counter >= teiler) then
                        counter <= 0;
                        clk_out <='1';
                    else
                        counter <= counter +1;
                        clk_out <= '0';
                    end if;
                end if;
            end if;
    end process;

end behavioral;