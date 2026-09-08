class Llmux < Formula
  desc "Local AI API gateway and multiplexer"
  homepage "https://github.com/zhMoody/llmux-cli-rs"
  version "0.5.22"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.22/llmux-aarch64-apple-darwin.tar.xz"
      sha256 "a41fd2f9157b459976ca474b80e93aae896b050ad6630144f90895b33ef52f99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.22/llmux-x86_64-apple-darwin.tar.xz"
      sha256 "e7ceba1b5121910fe55a5e1fc076b25fa0af0a69d907fd043de6f52e96e9bc92"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.22/llmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9392d465544baa5f75bf3d1a7e5d2a8ab3335d9c5e35935b8b424cacd8e9efb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.22/llmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6b5d17cb0611305ec4bf0b202b574b2961574f4d1287ae98a61d91d00b392fce"
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
