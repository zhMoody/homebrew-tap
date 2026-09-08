class Llmux < Formula
  desc "Local AI API gateway and multiplexer"
  homepage "https://github.com/zhMoody/llmux-cli-rs"
  version "0.4.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.3/llmux-aarch64-apple-darwin.tar.xz"
      sha256 "29bebdd652dbe6b31715bd4aaced2d3cce450018efcf8f4203cd5c36bbde4a8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.3/llmux-x86_64-apple-darwin.tar.xz"
      sha256 "4f26ee1fdb8c91499a5bebceac30cef502dbe8e1f7c132fb888d3622892ac953"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.3/llmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "de6357ed50de8933022b378570af7b7b5ff25efdb0f951a346d33c9d2353f0f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.3/llmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3581aee1888e8c58612f5bc78951e7bc06f062731c775277b6d7860766209316"
    end
  end
  license "AGPL-3.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "llmux"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "llmux"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "llmux"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "llmux"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
