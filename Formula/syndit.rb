class Syndit < Formula
  desc "CLI and MCP runtime for the syndit agent protocol"
  homepage "https://github.com/intuitive-compute/syndit"
  version "0.2.1"
  license "MIT"
  head "https://github.com/intuitive-compute/syndit.git", branch: "main"

  # Source fallback for archs without a prebuilt binary.
  url "https://github.com/intuitive-compute/syndit/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f911a69e476eac0cdcbcf0855a918a5037b27948f113166b9fcb2101bc710b3c"

  on_macos do
    on_arm do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.2.1/syndit-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "589c8d4b0dd5960dd9643cf12244b4e731b375a726844c81dd042f540ac0ed9f"
    end
    on_intel do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.2.1/syndit-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "3e69ca18ae5623094dd13e85eb960b9f27264468359a2e707eeea7aaf062f2d8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.2.1/syndit-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8abf575b67c5ea940fec1cccc7df5e4170c230a484a9cc3d9968bdc67e896e08"
    end
    on_arm do
      depends_on "rust" => :build
      depends_on "protobuf" => :build
    end
  end

  def install
    if File.exist?("Cargo.toml")
      system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/syndit-cli"
      system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/agent-runtime"
    else
      bin.install "syndit", "agent-runtime"
    end
  end

  test do
    assert_match "syndit", shell_output("#{bin}/syndit --version")
  end
end
