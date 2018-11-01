library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity impl_test_adder256s is
	generic (W : natural := 32);
	port (
		clk_256 : in  std_logic;
		clk_2   : in  std_logic;
		clk_3   : in  std_logic;
		clk_4   : in  std_logic;
		din     : in  std_logic_vector(31 downto 0); -- 適当な幅から水増しする
		sum_256_out : out std_logic_vector(31 downto 0);
		sum_2_out   : out std_logic_vector(31 downto 0);
		sum_3_out   : out std_logic_vector(31 downto 0);
		sum_4_out   : out std_logic_vector(31 downto 0)
	);
end entity;

architecture arch of impl_test_adder256s is

	signal d : std_logic_vector(256*W-1 downto 0);

	signal d_256 : std_logic_vector(256*W-1 downto 0);
	signal d_2   : std_logic_vector(256*W-1 downto 0);
	signal d_3   : std_logic_vector(256*W-1 downto 0);
	signal d_4   : std_logic_vector(256*W-1 downto 0);

	signal sum_256 : std_logic_vector(W-1 downto 0);
	signal sum_2   : std_logic_vector(W-1 downto 0);
	signal sum_3   : std_logic_vector(W-1 downto 0);
	signal sum_4   : std_logic_vector(W-1 downto 0);

	component adder256_256 is
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(    W-1 downto 0)
	);
	end component;

	component adder256_2 is
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(    W-1 downto 0)
	);
	end component;

	component adder256_3 is
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(    W-1 downto 0)
	);
	end component;

	component adder256_4 is
	port (
		clk : in  std_logic;
		d   : in  std_logic_vector(256*W-1 downto 0);
		sum : out std_logic_vector(    W-1 downto 0)
	);
	end component;

begin

	process(din)
	begin
		for i in 0 to 255 loop
			d(i*W + W-1 downto i*W) <= din;
		end loop;
	end process;

	process(clk_256)
	begin
		if rising_edge(clk_256) then
			d_256       <= d;
			sum_256_out <= sum_256;
		end if;
	end process;

	process(clk_2)
	begin
		if rising_edge(clk_2) then
			d_2       <= d;
			sum_2_out <= sum_2;
		end if;
	end process;

	process(clk_3)
	begin
		if rising_edge(clk_3) then
			d_3       <= d;
			sum_3_out <= sum_3;
		end if;
	end process;

	process(clk_4)
	begin
		if rising_edge(clk_4) then
			d_4       <= d;
			sum_4_out <= sum_4;
		end if;
	end process;

	adder256_256_inst : adder256_256
	port map (
		clk_256, -- : in  std_logic;
		d_256  , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_256  -- : out std_logic_vector(    W-1 downto 0)
	);

	adder256_2_inst : adder256_2
	port map (
		clk_2, -- : in  std_logic;
		d_2  , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_2  -- : out std_logic_vector(    W-1 downto 0)
	);

	adder256_3_inst : adder256_3
	port map (
		clk_3, -- : in  std_logic;
		d_3  , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_3  -- : out std_logic_vector(    W-1 downto 0)
	);

	adder256_4_inst : adder256_4
	port map (
		clk_4, -- : in  std_logic;
		d_4  , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_4  -- : out std_logic_vector(    W-1 downto 0)
	);

end architecture;