library IEEE;
use IEEE.std_logic_1164.all;

entity div is
  port (op1 : in std_logic_vector(15 downto 0);
        op2 : in std_logic_vector(7 downto 0);
        trg : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        done : out std_logic;
          q : out std_logic_vector(7 downto 0);
          r : out std_logic_vector(7 downto 0));
end div;

architecture behaviour of div is
  signal qin, qout : std_logic_vector(15 downto 0);
  signal minus, m, aout, ain, nin, nout : std_logic_vector(7 downto 0);
  signal state : std_logic_vector(1 downto 0);
  signal amxin, amxout : std_logic_vector(7 downto 0);
  signal nmxin, nmxout : std_logic_vector(7 downto 0);
  signal c, amxc, nmxc, donein : std_logic;
  component flipflop is
    port (d, clk, rst : in std_logic;
          q : out std_logic);
  end component;
  component reg8 is
    port (d : in std_logic_vector(7 downto 0);
          clk, rst : in std_logic;
          q : out std_logic_vector(7 downto 0));
  end component;
  component reg16 is
    port (d : in std_logic_vector(15 downto 0);
          clk, rst : in std_logic;
          q : out std_logic_vector(15 downto 0));
  end component;
  component add is
    port (op1, op2 : in std_logic_vector(7 downto 0);
          carry0 : in std_logic;
          c : out std_logic;
          rslt : out std_logic_vector(7 downto 0));
  end component;
begin
  nin <= "00010000";
  amxout <= (((ain(7) and not amxc) or (amxin(7) and amxc)) & ((ain(6) and not amxc) or (amxin(6) and amxc)) & ((ain(5) and not amxc) or (amxin(5) and amxc)) & ((ain(4) and not amxc) or (amxin(4) and amxc)) & ((ain(3) and not amxc) or (amxin(3) and amxc)) & ((ain(2) and not amxc) or (amxin(2) and amxc)) & ((ain(1) and not amxc) or (amxin(1) and amxc)) & ((ain(0) and not amxc) or (amxin(0) and amxc)));
  nmxout <= (((nin(7) and not nmxc) or (nmxin(7) and nmxc)) & ((nin(6) and not nmxc) or (nmxin(6) and nmxc)) & ((nin(5) and not nmxc) or (nmxin(5) and nmxc)) & ((nin(4) and not nmxc) or (nmxin(4) and nmxc)) & ((nin(3) and not nmxc) or (nmxin(3) and nmxc)) & ((nin(2) and not nmxc) or (nmxin(2) and nmxc)) & ((nin(1) and not nmxc) or (nmxin(1) and nmxc)) & ((nin(0) and not nmxc) or (nmxin(0) and nmxc)));
  q <= qout(7 downto 0);
  r <= aout;
  
  regdone : flipflop port map (
    d => donein,
    clk => clk,
    rst => rst,
    q => done);

  regq : reg16 port map (
    d => qin,
    clk => clk,
    rst => rst,
    q => qout);

  rega : reg8 port map (
    d => amxout,
    clk => clk,
    rst => rst,
    q => aout);

  regn : reg8 port map (
    d => nmxout,
    clk => clk,
    rst => rst,
    q => nout);

  adda : add port map (
    op1 => aout,
    op2 => m,
    carry0 => c,
    rslt => amxin);

  addn : add port map (
    op1 => nout,
    op2 => minus,
    carry0 => '0',
    rslt => nmxin);

  seq : process(clk, rst)
  begin
    if (rst = '1') then
      nmxc <= '0';
      state <= "11";
    elsif (clk'event and clk = '0') then
      if (state = "00") then
        ain <= aout(6 downto 0) & qout(15);
        qin(15 downto 1) <= qout(14 downto 0);
        if (aout(7) = '0') then
          c <= '1';
          m <= not op2;
        else
          c <= '0';
          m <= op2;
        end if;
        amxc <= '0';
        minus <= "00000000";
        state <= "01";
      elsif (state = "01") then
        amxc <= '1';
        minus <= "11111111";
        state <= "10";
      elsif (state = "10") then
        qin(0) <= not aout(7);
        if (nout = "00000000") then
          c <= '0';
          if (aout(7) = '1') then
            m <= op2;
          else
            m <= "00000000";
          end if;
          nmxc <= '0';
          donein <= '1';
          state <= "11";
        else
          ain <= aout;
          amxc <= '0';
          minus <= "00000000";
          state <= "00";
        end if;
      elsif (state = "11") then
        amxc <= '0';
        if (trg = '1') then
          ain <= "00000000";
          qin <= op1;
          nmxc <= '1';
          minus <= "00000000";
          donein <= '0';
          state <= "00";
        else
          ain <= aout;
        end if;
      end if;
    end if;
  end process seq;
end behaviour;