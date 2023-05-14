library IEEE;
use IEEE.std_logic_1164.ALL;

entity flipflop is
  port (d   : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic);
end flipflop;

architecture behaviour of flipflop is
begin
  seq : process(clk, rst)
  begin
    if (rst = '1') then
      q <= '0';
    elsif (clk'event and clk = '1') then
      q <= d;
    end if;
  end process seq;
end behaviour;