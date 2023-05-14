library IEEE;
use IEEE.std_logic_1164.all;

entity divtb is
end divtb;

architecture behaviour of divtb is
  signal op1tb : std_logic_vector(15 downto 0);
  signal op2tb, qtb, rtb : std_logic_vector(7 downto 0);
  signal trgtb, clktb, rsttb, donetb : std_logic;
  component div is
    port (op1 : in std_logic_vector(15 downto 0);
          op2 : in std_logic_vector(7 downto 0);
          trg, clk, rst : in std_logic;
          done : out std_logic;
          q, r : out std_logic_vector(7 downto 0));
  end component;
begin
  divv : div port map (
    op1 => op1tb,
    op2 => op2tb,
    trg => trgtb,
    clk => clktb,
    rst => rsttb,
    done => donetb,
    q => qtb,
    r => rtb);
  
  clkgen : process
  begin
    clktb <= '0';
    wait for 5ns;
    clktb <= '1';
    wait for 5ns;
  end process clkgen;

  dgen : process
  begin
    trgtb <= '0';
    --op1tb <= "0000001101101101";
    --op2tb <= "00001100";
    op1tb <= "0000011001110010";
    op2tb <= "00100010";
    --op1tb <= "0000000000001011";
    --op2tb <= "00000011";
    rsttb <= '1';
    wait for 5 ns;
    rsttb <= '0';
    trgtb <= '1';
    wait for 10 ns;
    trgtb <= '0';
    --op1tb <= "0010001010001111";
    --op2tb <= "00110000";
    --wait for 10ns;
    --op1tb <= "0000110011010010";
    --op2tb <= "00100100";
    --wait for 10ns;
    --op1tb <= "0000111111110010";
    --op2tb <= "10001101";
    --wait for 10ns;
    --op1tb <= "1011111110010001";
    --op2tb <= "01101101";
    --wait for 10ns;
    --op1tb <= "0111011111111000";
    --op2tb <= "10011100";
    --wait for 10ns;
    --wait for 10ns;
    --op1tb <= "0010010100111011";
    --op2tb <= "00011010";
    --wait for 10ns;
    --op1tb <= "0101111111000111";
    --op2tb <= "01010100";
    --wait for 10ns;
    --op1tb <= "0010110000000110";
    --op2tb <= "00101110";
    --wait for 10ns;
    --op1tb <= "0011100000000001";
    --op2tb <= "11010101";
    wait;
  end process dgen;
end behaviour;