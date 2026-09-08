class Llmux < Formula
  desc "Local AI API gateway and multiplexer"
  homepage "https://github.com/zhMoody/llmux-cli-rs"
  version "0.5.24"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.24/llmux-aarch64-apple-darwin.tar.xz"
      sha256 "002250517707ce3a7156a4bd9dc29298c3ade35cc22f86b6a3bdab5a33dc33c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.24/llmux-x86_64-apple-darwin.tar.xz"
      sha256 "b4e816934107ebc5a7332fe68f731106817b4f1c290e9ac7e9ae00347518ce43"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.24/llmux-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd39a84dbe7fea1267c6b2a783ce39ca6ca53c768a9ad43326d0753e2a4d84fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhMoody/llmux-cli-rs/releases/download/v0.5.24/llmux-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7cb3994fcc76ed6b7645d456bee23c77e7ed7bad7b916610d87243b414693104"
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
