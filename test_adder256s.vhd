library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_adder256s is
	generic (
		W : natural := 32;
		CYCLE : time := 5 ns;
		DELAY : time := 1 ns
	);
end entity;

architecture arch of test_adder256s is

	signal clk : std_logic;
	signal d   : std_logic_vector(256*W-1 downto 0) := (others => '0');
	signal sum_256 : std_logic_vector(    W-1 downto 0);
	signal sum_2   : std_logic_vector(    W-1 downto 0);
	signal sum_3   : std_logic_vector(    W-1 downto 0);
	signal sum_4   : std_logic_vector(    W-1 downto 0);

	signal count : integer := 0;

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

	process begin
		clk   <= '1'; wait for CYCLE/2;
		clk   <= '0'; wait for CYCLE/2;
	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			count <= count + 1;
			d(count*W + W-1 downto count*W) <= std_logic_vector(to_unsigned(count, 32));
		end if;
	end process;

	adder256_256_inst : adder256_256
	port map (
		clk    , -- : in  std_logic;
		d      , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_256  -- : out std_logic_vector(    W-1 downto 0)
	);

	adder256_2_inst : adder256_2
	port map (
		clk    , -- : in  std_logic;
		d      , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_2    -- : out std_logic_vector(    W-1 downto 0)
	);

	adder256_3_inst : adder256_3
	port map (
		clk    , -- : in  std_logic;
		d      , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_3    -- : out std_logic_vector(    W-1 downto 0)
	);

	adder256_4_inst : adder256_4
	port map (
		clk    , -- : in  std_logic;
		d      , -- : in  std_logic_vector(256*W-1 downto 0);
		sum_4    -- : out std_logic_vector(    W-1 downto 0)
	);

	process begin
		wait until(count = 300);
		report "Test Completed" severity failure;
		wait;
	end process;

end architecture;