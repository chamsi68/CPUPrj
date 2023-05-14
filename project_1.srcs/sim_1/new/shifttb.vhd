library IEEE;
use IEEE.std_logic_1164.all;

entity shifttb is
end shifttb;

architecture behaviour of shifttb is
  signal op1tb, rslttb : std_logic_vector(7 downto 0);
  signal op2tb : std_logic_vector(2 downto 0);
  signal dtb : std_logic;
  component shift is
    port (op1 : in std_logic_vector(7 downto 0);
          op2 : in std_logic_vector(2 downto 0);
          d   : in std_logic;
         rslt : out std_logic_vector(7 downto 0));
  end component;
begin
  shiftt : shift port map (
    op2 => op2tb,
    op1 => op1tb,
    d => dtb,
    rslt => rslttb);

  dgen : process
  begin
    op1tb <= "00000000";
    op2tb <= "000";
    dtb <= '0';
    wait for 10ns;
    op1tb <= "10100110";
    op2tb <= "010";
    wait for 10ns;
    dtb <= '1';
    wait;
  end process dgen;
end behaviour;