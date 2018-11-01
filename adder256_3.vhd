library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder256_3 is
	generic (W : natural := 32);
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(W-1 downto 0)
	);
end entity;

architecture arch of adder256_3 is

    signal sum1 : unsigned(86*W-1 downto 0) := (others => '0');
    signal sum2 : unsigned(29*W-1 downto 0) := (others => '0');
    signal sum3 : unsigned(10*W-1 downto 0) := (others => '0');
    signal sum4 : unsigned( 4*W-1 downto 0) := (others => '0');
    signal sum5 : unsigned( 2*W-1 downto 0) := (others => '0');

	signal d_in    : unsigned(256*W-1 downto 0) := (others => '0');
	signal sum_reg : unsigned(    W-1 downto 0) := (others => '0');
	signal sum_out : unsigned(    W-1 downto 0) := (others => '0');

begin

	process(clk)
	begin
		if rising_edge(clk) then
			for i in 0 to 83 loop
				sum1(i*W + W-1 downto i*W) <=
					d_in((i*3+0)*W + W-1 downto (i*3+0)*W) +
					d_in((i*3+1)*W + W-1 downto (i*3+1)*W) +
					d_in((i*3+2)*W + W-1 downto (i*3+2)*W);
			end loop;
			sum1(84*W + W-1 downto 84*W) <=
				d_in(252*W + W-1 downto 252*W) +
				d_in(253*W + W-1 downto 253*W);
			sum1(85*W + W-1 downto 85*W) <=
				d_in(254*W + W-1 downto 254*W) +
				d_in(255*W + W-1 downto 255*W);

			for i in 0 to 27 loop
				sum2(i*W + W-1 downto i*W) <=
					sum1((i*3+0)*W + W-1 downto (i*3+0)*W) +
					sum1((i*3+1)*W + W-1 downto (i*3+1)*W) +
					sum1((i*3+2)*W + W-1 downto (i*3+2)*W);
			end loop;
			sum2(28*W + W-1 downto 28*W) <=
				sum1(84*W + W-1 downto 84*W) +
				sum1(85*W + W-1 downto 85*W);

			for i in 0 to 8 loop
				sum3(i*W + W-1 downto i*W) <=
					sum2((i*3+0)*W + W-1 downto (i*3+0)*W) +
					sum2((i*3+1)*W + W-1 downto (i*3+1)*W) +
					sum2((i*3+2)*W + W-1 downto (i*3+2)*W);
			end loop;
			sum3(9*W + W-1 downto 9*W) <=
				sum2(27*W + W-1 downto 27*W) +
				sum2(28*W + W-1 downto 28*W);

			for i in 0 to 1 loop
				sum4(i*W + W-1 downto i*W) <=
					sum3((i*3+0)*W + W-1 downto (i*3+0)*W) +
					sum3((i*3+1)*W + W-1 downto (i*3+1)*W) +
					sum3((i*3+2)*W + W-1 downto (i*3+2)*W);
			end loop;
			sum4(2*W + W-1 downto 2*W) <=
				sum3(6*W + W-1 downto 6*W) +
				sum3(7*W + W-1 downto 7*W);
			sum4(3*W + W-1 downto 3*W) <=
				sum3(8*W + W-1 downto 8*W) +
				sum3(9*W + W-1 downto 9*W);

			sum5(0*W + W-1 downto 0*W) <=
				sum4(0*W + W-1 downto 0*W) +
				sum4(1*W + W-1 downto 1*W);
			sum5(1*W + W-1 downto 1*W) <=
				sum4(2*W + W-1 downto 2*W) +
				sum4(3*W + W-1 downto 3*W);

			sum_reg <=
				sum5(0*W + W-1 downto 0*W) +
				sum5(1*W + W-1 downto 1*W);
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