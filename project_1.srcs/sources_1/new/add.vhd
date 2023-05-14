library IEEE;
use IEEE.std_logic_1164.all;

entity add is
  port (op1 : in std_logic_vector(7 downto 0);
        op2 : in std_logic_vector(7 downto 0);
        carry0 : in std_logic;
        c   : out std_logic;
       rslt : out std_logic_vector(7 downto 0));
end add;

architecture behaviour of add is
  signal carry1, carry2, carry3, carry4, carry5, carry6, carry7 : std_logic;
begin
  rslt(0) <= op1(0) xor op2(0) xor carry0;
  carry1 <= (op1(0) and op2(0)) or (op1(0) and carry0) or (op2(0) and carry0);
  rslt(1) <= op1(1) xor op2(1) xor carry1;
  carry2 <= (op1(1) and op2(1)) or (op1(1) and carry1) or (op2(1) and carry1);
  rslt(2) <= op1(2) xor op2(2) xor carry2;
  carry3 <= (op1(2) and op2(2)) or (op1(2) and carry2) or (op2(2) and carry2);
  rslt(3) <= op1(3) xor op2(3) xor carry3;
  carry4 <= (op1(3) and op2(3)) or (op1(3) and carry3) or (op2(3) and carry3);
  rslt(4) <= op1(4) xor op2(4) xor carry4;
  carry5 <= (op1(4) and op2(4)) or (op1(4) and carry4) or (op2(4) and carry4);
  rslt(5) <= op1(5) xor op2(5) xor carry5;
  carry6 <= (op1(5) and op2(5)) or (op1(5) and carry5) or (op2(5) and carry5);
  rslt(6) <= op1(6) xor op2(6) xor carry6;
  carry7 <= (op1(6) and op2(6)) or (op1(6) and carry6) or (op2(6) and carry6);
  rslt(7) <= op1(7) xor op2(7) xor carry7;
  c <= (op1(7) and op2(7)) or (op1(7) and carry7) or (op2(7) and carry7);
end behaviour;