class Llmux < Formula
  desc "Local AI API gateway and multiplexer"
  homepage "https://github.com/zhMoody/llmux-cli-rs"
  version "0.4.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.4/llmux-aarch64-apple-darwin.tar.xz"
      sha256 "3a5f6dafb16f4d85729b317e75ac96c79a5c05628f1ead68a1831d169db6cb46"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.4/llmux-x86_64-apple-darwin.tar.xz"
      sha256 "2bee1d67100e480ba71cc48b5b69df368a2b1f37f9c4bdf3f18f4f8fa95da74e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.4/llmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "065cd41870aa283b3bac4afe69664b57c229b083262863cf0066c5b2208bd381"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.4.4/llmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2bc77aeb61883ad3451f47bca3427ba8f4c69c70bf77312fffee651683b33d7c"
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
