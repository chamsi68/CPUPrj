library IEEE;
use IEEE.std_logic_1164.all;

entity shift is
  port (op1 : in std_logic_vector(7 downto 0);
        op2 : in std_logic_vector(2 downto 0);
        d   : in std_logic; -- 0 : shl, 1 : shr
       rslt : out std_logic_vector(7 downto 0));
end shift;

architecture behaviour of shift is
  signal wire00, wire01, wire02, wire03, wire04, wire05, wire06, wire07 : std_logic;
  signal wire10, wire11, wire12, wire13, wire14, wire15, wire16, wire17 : std_logic;
  signal wire20, wire21, wire22, wire23, wire24, wire25, wire26, wire27 : std_logic;
  signal wire30, wire31, wire32, wire33, wire34, wire35, wire36, wire37 : std_logic;
begin
  wire00 <= (op1(7) and (not d)) or (op1(0) and d);
  wire01 <= (op1(6) and (not d)) or (op1(1) and d);
  wire02 <= (op1(5) and (not d)) or (op1(2) and d);
  wire03 <= (op1(4) and (not d)) or (op1(3) and d);
  wire04 <= (op1(3) and (not d)) or (op1(4) and d);
  wire05 <= (op1(2) and (not d)) or (op1(5) and d);
  wire06 <= (op1(1) and (not d)) or (op1(6) and d);
  wire07 <= (op1(0) and (not d)) or (op1(7) and d);

  wire10 <= (wire00 and (not op2(0))) or (wire01 and op2(0));
  wire11 <= (wire01 and (not op2(0))) or (wire02 and op2(0));
  wire12 <= (wire02 and (not op2(0))) or (wire03 and op2(0));
  wire13 <= (wire03 and (not op2(0))) or (wire04 and op2(0));
  wire14 <= (wire04 and (not op2(0))) or (wire05 and op2(0));
  wire15 <= (wire05 and (not op2(0))) or (wire06 and op2(0));
  wire16 <= (wire06 and (not op2(0))) or (wire07 and op2(0));
  wire17 <= (wire07 and (not op2(0)));
  
  wire20 <= (wire10 and (not op2(1))) or (wire12 and op2(1));
  wire21 <= (wire11 and (not op2(1))) or (wire13 and op2(1));
  wire22 <= (wire12 and (not op2(1))) or (wire14 and op2(1));
  wire23 <= (wire13 and (not op2(1))) or (wire15 and op2(1));
  wire24 <= (wire14 and (not op2(1))) or (wire16 and op2(1));
  wire25 <= (wire15 and (not op2(1))) or (wire17 and op2(1));
  wire26 <= (wire16 and (not op2(1)));
  wire27 <= (wire17 and (not op2(1)));
  
  wire30 <= (wire20 and (not op2(2))) or (wire24 and op2(2));
  wire31 <= (wire21 and (not op2(2))) or (wire25 and op2(2));
  wire32 <= (wire22 and (not op2(2))) or (wire26 and op2(2));
  wire33 <= (wire23 and (not op2(2))) or (wire27 and op2(2));
  wire34 <= (wire24 and (not op2(2)));
  wire35 <= (wire25 and (not op2(2)));
  wire36 <= (wire26 and (not op2(2)));
  wire37 <= (wire27 and (not op2(2)));
  
  rslt(0) <= (wire37 and (not d)) or (wire30 and d);
  rslt(1) <= (wire36 and (not d)) or (wire31 and d);
  rslt(2) <= (wire35 and (not d)) or (wire32 and d);
  rslt(3) <= (wire34 and (not d)) or (wire33 and d);
  rslt(4) <= (wire33 and (not d)) or (wire34 and d);
  rslt(5) <= (wire32 and (not d)) or (wire35 and d);
  rslt(6) <= (wire31 and (not d)) or (wire36 and d);
  rslt(7) <= (wire30 and (not d)) or (wire37 and d);
end behaviour;