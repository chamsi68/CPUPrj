library IEEE;
use IEEE.std_logic_1164.all;

entity multtb is
end multtb;

architecture behaviour of multtb is
  signal op1tb, op2tb : std_logic_vector(7 downto 0);
  signal rslttb : std_logic_vector(15 downto 0);
  component mult is
    port (op1, op2 : in std_logic_vector(7 downto 0);
          rslt : out std_logic_vector(15 downto 0));
  end component;
begin
  multt : mult port map (
    op1 => op1tb,
    op2 => op2tb,
    rslt => rslttb);
  
  dgen : process
  begin
    op1tb <= "00000000";
    op2tb <= "00000000";
    wait for 10ns;
    op1tb <= "10100110";
    op2tb <= "00110000";
    wait for 10ns;
    op1tb <= "10011010";
    op2tb <= "00100100";
    wait for 10ns;
    op1tb <= "01100010";
    op2tb <= "10001101";
    wait for 10ns;
    op1tb <= "01101001";
    op2tb <= "01101101";
    wait for 10ns;
    op1tb <= "10110011";
    op2tb <= "10011100";
    wait for 10ns;
    op1tb <= "01110110";
    op2tb <= "00001100";
    wait for 10ns;
    op1tb <= "01011100";
    op2tb <= "00011010";
    wait for 10ns;
    op1tb <= "10110011";
    op2tb <= "01010100";
    wait for 10ns;
    op1tb <= "10101110";
    op2tb <= "00101110";
    wait for 10ns;
    op1tb <= "00110111";
    op2tb <= "11010101";
    wait for 10ns;
    op1tb <= "00000000";
    op2tb <= "00000000";
    wait;
  end process dgen;
end behaviour;