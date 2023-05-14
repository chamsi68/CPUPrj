library IEEE;
use IEEE.std_logic_1164.ALL;

entity flipfloptb is
end flipfloptb;

architecture behaviour of flipfloptb is
  signal dtb, qtb, clkt : std_logic;
  signal rsttb : std_logic := '0';
  component flipflop is
    port (d, clk, rst : in std_logic;
          q : out std_logic);
  end component;
begin
  flipflopp : flipflop port map (
    d => dtb,
    clk => clktb,
    rst => rsttb,
    q => qtb);

  clkgen : process
  begin
    clktb <= '0';
    wait for 5ns;
    clktb <= '1';
    wait for 5ns;
  end process clkgen;

  dgen : process
  begin
    dtb <= '0';
    wait for 23ns;
    dtb <= '1';
    wait for 100ns;
    dtb <= '0';
    wait;
  end process dgen;
end behaviour;