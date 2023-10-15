library ieee;
use ieee.std_logic_1164.all;

entity bitComparator is
  port(
    a           :       in      std_logic_vector(3 downto 0);
    b           :       in      std_logic_vector(3 downto 0);
    sig         :       in      std_logic;
    lg          :       out     std_logic;
    eq          :       out     std_logic;
    ls          :       out     std_logic
  );  
end entity bitComparator;

architecture rtl of bitComparator is
  signal firstOne       :       std_logic_vector(4 downto 0);
  signal xorComp        :       std_logic_vector(3 downto 0);
  signal comp           :       std_logic_vector(4 downto 0);
begin
  xorComp <= a xor b;
  firstOne(4) <= '0';
  comp(4) <= '0';
  comparison: for i in 3 downto 0 generate
    firstOne(i) <= '1' when (firstOne(i+1) or xorComp(i))='1' else
                   '0';
    comp(i) <= comp(i+1) when firstOne(i+1)='1' else
               '1' when (firstOne(i) and a(i))='1' else
               '0';
  end generate;
  eq <= not firstOne(0);
  lg <= comp(0);
  ls <= not comp(0);
end architecture rtl;

    
