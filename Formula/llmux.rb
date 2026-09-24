class Llmux < Formula
  desc "Local AI API gateway and multiplexer"
  homepage "https://github.com/zhMoody/llmux-cli-rs"
  version "0.5.25"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.25/llmux-aarch64-apple-darwin.tar.xz"
      sha256 "6ebd551646fd3a1d1c4659e66f3e577396b9fe4623a5507c8f997d1e81c281d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.25/llmux-x86_64-apple-darwin.tar.xz"
      sha256 "0b439a66f5c5b749843d9df0586dc5259049c4ff3f4a5338b6dde0dba575f3c4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.25/llmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa6c7b513bdb6c3fb985944f7ca016c676ba3ba24390fa3f07259e194e54dc33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.25/llmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6b1680809869bfc838a3fd557f8c067e726c324c5c5743e691fe9c88124675f9"
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
