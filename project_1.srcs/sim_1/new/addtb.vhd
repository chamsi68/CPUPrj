library IEEE;
use IEEE.std_logic_1164.all;

entity addtb is
end addtb;

architecture behaviour of addtb is
  signal op1tb, op2tb, rslttb : std_logic_vector(7 downto 0);
  signal ctb : std_logic;
  component add is
    port (op1, op2 : in std_logic_vector(7 downto 0);
          carry0 : in std_logic;
          c : out std_logic;
          rslt : out std_logic_vector(7 downto 0));
  end component;
begin
  addd : add port map (
    op1 => op1tb,
    op2 => op2tb,
    carry0 => '0',
    c => ctb,
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