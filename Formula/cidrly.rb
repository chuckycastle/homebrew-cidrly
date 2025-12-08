class Cidrly < Formula
  desc "Network architecture and design planning CLI tool"
  homepage "https://github.com/chuckycastle/cidrly"
  url "https://registry.npmjs.org/cidrly/-/cidrly-0.5.1.tgz"
  sha256 "58eb095f2105a226a9e045f0921a902d573e5ed25c32b5f43e583eda35ac7ade"
  license "CC-BY-NC-SA-4.0"

  depends_on "node"

  def install
    # The npm tarball already contains the built dist/ directory
    # Just need to install dependencies (not build)
    system "npm", "install", *std_npm_args(prefix: false)
    libexec.install Dir["*"]

    # Create a wrapper script to run cidrly
    (bin/"cidrly").write_env_script(
      "#{Formula["node"].opt_bin}/node",
      "#{libexec}/dist/cli.js",
      PATH: "#{Formula["node"].opt_bin}:$PATH"
    )
  end

  test do
    # Test that the binary runs
    assert_match "cidrly", shell_output("#{bin}/cidrly --help 2>&1", 0)
  end
end
