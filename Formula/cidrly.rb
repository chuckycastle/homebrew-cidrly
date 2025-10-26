class Cidrly < Formula
  desc "Network architecture and design planning CLI tool"
  homepage "https://github.com/chuckycastle/cidrly"
  url "https://registry.npmjs.org/cidrly/-/cidrly-0.1.2.tgz"
  sha256 "dd11b904647b69c810104d303d1f7a0543b2958ebaba7fb02c18520c87290cd3"
  license "ISC"

  depends_on "node@20"

  def install
    # The npm tarball already contains the built dist/ directory
    # No need to run npm install or build:prod
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
