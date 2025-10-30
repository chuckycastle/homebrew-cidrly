class Cidrly < Formula
  desc "Network architecture and design planning CLI tool"
  homepage "https://github.com/chuckycastle/cidrly"
  url "https://registry.npmjs.org/cidrly/-/cidrly-0.2.0.tgz"
  sha256 "5b0e010728d4475393d3821ba70d1bd19d5bcd426da287ef7e71c4cd48fab01f"
  license "ISC"

  depends_on "node@20"

  def install
    # The npm tarball already contains the built dist/ directory
    # Just need to install dependencies (not build)
    system "npm", "install", *std_npm_args(prefix: false)
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
