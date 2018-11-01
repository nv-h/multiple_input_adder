library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder256_256 is
	generic (W : natural := 32);
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(    W-1 downto 0)
	);
end entity;

architecture arch of adder256_256 is

	signal sumComb : unsigned(    W-1 downto 0);
	signal d_in    : unsigned(256*W-1 downto 0) := (others => '0');
	signal sum_reg : unsigned(    W-1 downto 0) := (others => '0');
	signal sum_out : unsigned(    W-1 downto 0) := (others => '0');

begin

	process(d_in)
		variable temp : unsigned(W-1 downto 0);
	begin
		temp := (others => '0');
		for i in 0 to 255 loop
			temp := temp + d_in(i*W + W-1 downto i*W);
		end loop;
		sumComb <= temp;
	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			sum_reg <= sumComb;
		end if;
	end process;

	--process(clk)
	--begin
	--	if rising_edge(clk) then
			d_in    <= unsigned(d);
			sum_out <= sum_reg;
	--	end if;
	--end process;

	sum <= std_logic_vector(sum_out);

end architecture;