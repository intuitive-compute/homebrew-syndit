class Syndit < Formula
  desc "CLI and MCP runtime for the syndit agent protocol"
  homepage "https://github.com/intuitive-compute/syndit"
  url "https://github.com/intuitive-compute/syndit/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "209503759288195716978d38ab0f4738e733748be7cac02ca915813588a8e324"
  license "MIT OR Apache-2.0"
  head "https://github.com/intuitive-compute/syndit.git", branch: "main"

  depends_on "rust" => :build
  depends_on "protobuf" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix,
           "--path", "crates/syndit-cli"
    system "cargo", "install", "--locked", "--root", prefix,
           "--path", "crates/agent-runtime"
  end

  test do
    assert_match "syndit", shell_output("#{bin}/syndit --version")
  end
end
