library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
  port (opc : in std_logic_vector(3 downto 0);
        ops : in std_logic_vector(23 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        done : out std_logic;
        rslts : out std_logic_vector(15 downto 0));
end ALU;

architecture behaviour of ALU is
  signal multrslt, divop1 : std_logic_vector(15 downto 0);
  signal addop1, addop2, addrslt, multop1, multop2, divop2, divq, divr, shiftop1, shiftrslt : std_logic_vector(7 downto 0);
  signal shiftop2 : std_logic_vector(2 downto 0);
  signal addc, addcarry0, divtrg, divclk, divrst, divdone, shiftd, divtrgtmp, trgregin, trgreg12, trgregout : std_logic;
  component flipflop is
    port (d, clk, rst : in std_logic;
          q : out std_logic);
  end component;
  component add is
    port (op1, op2 : in std_logic_vector(7 downto 0);
          carry0 : in std_logic;
          c : out std_logic;
          rslt : out std_logic_vector(7 downto 0));
  end component;
  component mult is
    port (op1, op2 : in std_logic_vector(7 downto 0);
          rslt : out std_logic_vector(15 downto 0));
  end component;
  component div is
    port (op1 : in std_logic_vector(15 downto 0);
          op2 : in std_logic_vector(7 downto 0);
          trg, clk, rst : in std_logic;
          done : out std_logic;
          q, r : out std_logic_vector(7 downto 0));
  end component;
  component shift is
    port (op1 : in std_logic_vector(7 downto 0);
          op2 : in std_logic_vector(2 downto 0);
          d   : in std_logic;
         rslt : out std_logic_vector(7 downto 0));
  end component;
begin
  trgregin <= not opc(3) and not opc(2) and opc(1) and opc(0);
  divtrg <= trgregin and not trgregout;

  trgreg1 : flipflop port map (
    d => trgregin,
    clk => clk,
    rst => rst,
    q => trgreg12);

  trgreg2 : flipflop port map (
    d => trgreg12,
    clk => clk,
    rst => rst,
    q => trgregout);

  addinst : add port map (
    op1 => addop1,
    op2 => addop2,
    carry0 => addcarry0,
    c => addc,
    rslt => addrslt);

  multinst : mult port map (
    op1 => multop1,
    op2 => multop2,
    rslt => multrslt);

  divinst : div port map (
    op1 => divop1,
    op2 => divop2,
    trg => divtrg,
    clk => clk,
    rst => rst,
    done => divdone,
    q => divq,
    r => divr);

  shiftinst : shift port map (
    op1 => shiftop1,
    op2 => shiftop2,
    d => shiftd,
    rslt => shiftrslt);

  addop1 <= ops(15 downto 8) when opc = "0000" else
            "00000000";
  addop2 <= ops(7 downto 0) when opc = "0000" else
            not ops(7 downto 0) when opc = "0001" else
            "00000000";
  addcarry0 <= '1' when opc = "0001" else
               '0';
  multop1 <= ops(15 downto 8) when opc = "0010" else
             "00000000";
  multop2 <= ops(7 downto 0) when opc = "0010" else
             "00000000";
  divop1 <= ops(23 downto 8) when opc = "0011" else
            "0000000000000000";
  divop2 <= ops(7 downto 0) when opc = "0011" else
            "00000000";
  shiftop1 <= ops(11 downto 4) when opc(3 downto 1) = "010" else
              "00000000";
  shiftop2 <= ops(2 downto 0) when opc(3 downto 1) = "010" else
              "000";
  shiftd <=  opc(0) when opc(3 downto 1) = "010" else
             '0';
  done <= divdone when opc = "0011" else
          '1';
  rslts <= "00000000" & addrslt when opc(3 downto 1) = "000" else
           multrslt when opc = "0010" else
           divr & divq when opc = "0011" else
           "00000000" & shiftrslt when opc(3 downto 1) = "010" else
           "00000000" & (ops(15 downto 8) and ops(7 downto 0)) when opc = "0110" else
           "00000000" & (ops(15 downto 8) or ops(7 downto 0)) when opc = "0111" else
           "00000000" & (ops(15 downto 8) xor ops(7 downto 0)) when opc = "1000" else
           "00000000" & (not ops(7 downto 0)) when opc = "1001" else
           "0000000000000000";

end behaviour;
