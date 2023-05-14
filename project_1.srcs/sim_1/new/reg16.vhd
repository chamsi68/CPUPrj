library IEEE;
use IEEE.std_logic_1164.ALL;

entity reg16 is
  port (d   : in std_logic_vector(15 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic_vector(15 downto 0));
end reg16;

architecture behaviour of reg16 is
begin
  seq : process(clk, rst)
  begin
    if (rst = '1') then
      q <= "0000000000000000";
    elsif (clk'event and clk = '1') then
      q <= d;
    end if;
  end process seq;
end behaviour;