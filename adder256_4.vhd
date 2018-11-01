library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder256_4 is
	generic (W : natural := 32);
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(W-1 downto 0)
	);
end entity;

architecture arch of adder256_4 is

	signal sum1 : unsigned(64*W-1 downto 0) := (others => '0');
	signal sum2 : unsigned(16*W-1 downto 0) := (others => '0');
	signal sum3 : unsigned( 4*W-1 downto 0) := (others => '0');

	signal d_in    : unsigned(256*W-1 downto 0) := (others => '0');
	signal sum_reg : unsigned(    W-1 downto 0) := (others => '0');
	signal sum_out : unsigned(    W-1 downto 0) := (others => '0');

begin

	process(clk)
	begin
		if rising_edge(clk) then
			for i in 0 to 63 loop
				sum1(i*W + W-1 downto i*W) <=
					d_in((i*4+0)*W + W-1 downto (i*4+0)*W) +
					d_in((i*4+1)*W + W-1 downto (i*4+1)*W) +
					d_in((i*4+2)*W + W-1 downto (i*4+2)*W) +
					d_in((i*4+3)*W + W-1 downto (i*4+3)*W);
			end loop;

			for i in 0 to 15 loop
				sum2(i*W + W-1 downto i*W) <=
					sum1((i*4+0)*W + W-1 downto (i*4+0)*W) +
					sum1((i*4+1)*W + W-1 downto (i*4+1)*W) +
					sum1((i*4+2)*W + W-1 downto (i*4+2)*W) +
					sum1((i*4+3)*W + W-1 downto (i*4+3)*W);
			end loop;

			for i in 0 to 3 loop
				sum3(i*W + W-1 downto i*W) <=
					sum2((i*4+0)*W + W-1 downto (i*4+0)*W) +
					sum2((i*4+1)*W + W-1 downto (i*4+1)*W) +
					sum2((i*4+2)*W + W-1 downto (i*4+2)*W) +
					sum2((i*4+3)*W + W-1 downto (i*4+3)*W);
			end loop;

			sum_reg <=
				sum3(0*W + W-1 downto 0*W) +
				sum3(1*W + W-1 downto 1*W) +
				sum3(2*W + W-1 downto 2*W) +
				sum3(3*W + W-1 downto 3*W);
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