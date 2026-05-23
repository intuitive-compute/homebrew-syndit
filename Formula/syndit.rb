class Syndit < Formula
  desc "CLI and MCP runtime for the syndit agent protocol"
  homepage "https://github.com/intuitive-compute/syndit"
  version "0.1.1"
  license "MIT"
  head "https://github.com/intuitive-compute/syndit.git", branch: "main"

  # Source fallback for archs without a prebuilt binary.
  url "https://github.com/intuitive-compute/syndit/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dc6c791904f6d3e2e344e39009faeea1992e1c0a0213db09df60c729e5768f7a"

  on_macos do
    on_arm do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.1.1/syndit-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "736ee2bd39e8a99f87914b08107a1739005dfadf6986d2663feccbecccd6d003"
    end
    on_intel do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.1.1/syndit-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "b62a22f1c757b4bb6783628d0bb17e8d34bd934304847f9f7a27a0a09552afb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.1.1/syndit-v0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3de39ce6706c9f9e4e6af4c540f492175da79bd9eaca3b5a9139b45b53209eb6"
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
