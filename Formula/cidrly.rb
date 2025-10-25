class Cidrly < Formula
  desc "Network architecture and design planning CLI tool"
  homepage "https://github.com/chuckycastle/cidrly"
  url "https://github.com/chuckycastle/cidrly/archive/refs/tags/v1.0.0-beta.1.tar.gz"
  sha256 "6fedaeab6ca71a4d321834cb25dd6c461d0afcd3f20d9bc9cf829c402551d248"
  license "ISC"

  depends_on "node@20"

  def install
    system "npm", "install", *std_npm_args(prefix: false)
    system "npm", "run", "build:prod"

    # Install the built package
    libexec.install Dir["*"]

    # Create a wrapper script to run cidrly
    (bin/"cidrly").write_env_script(
      "#{Formula["node@20"].opt_bin}/node",
      "#{libexec}/dist/cli.js",
      PATH: "#{Formula["node@20"].opt_bin}:$PATH"
    )
  end

  test do
    # Test that the binary runs
    assert_match "cidrly", shell_output("#{bin}/cidrly --help 2>&1", 0)
  end
end
