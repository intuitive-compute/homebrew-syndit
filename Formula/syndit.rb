class Syndit < Formula
  desc "CLI and MCP runtime for the syndit agent protocol"
  homepage "https://github.com/intuitive-compute/syndit"
  version "0.2.0"
  license "MIT"
  head "https://github.com/intuitive-compute/syndit.git", branch: "main"

  # Source fallback for archs without a prebuilt binary.
  url "https://github.com/intuitive-compute/syndit/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "a59416610597ebecf5ada3a0c83c85edabc40c85e70945557cddcf361a62d494"

  on_macos do
    on_arm do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.2.0/syndit-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "6b1892b1558fc25ba9d7ba1975d956d579cd55cb75a6a0ce67a73a2ea6747422"
    end
    on_intel do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.2.0/syndit-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "9725062d7889070e00f32d4578f6416e60918c818d4061259174e1ef962a005d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/intuitive-compute/syndit/releases/download/v0.2.0/syndit-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67a68e7550bf7f058ec33a03beee22fa1e97560acc85552b9ff678f76c5b803c"
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
