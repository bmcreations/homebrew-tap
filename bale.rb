class Bale < Formula
  desc "Keeps agent worktrees from filling your disk"
  homepage "https://github.com/bmcreations/bale"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.0/bale-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "4c3aded8a262ac77e827c380d353d9066012cc005cecb50b1a21aee8226ac3a6"
    end
    on_intel do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.0/bale-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "6eb07dd54a09a79238dabd6bef3b94e34e04559734d5ed649b02cf7d462fd960"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.0/bale-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "debc0cdd6b2c07802004b21532fb6ad0e9f6410163fb5644177b0035fe4ec345"
    end
    on_intel do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.0/bale-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6ee25443f80ea7ed9d01e943ccac6f02060965a7e66d0bfe4ab7dd7ad2b65cd0"
    end
  end

  def install
    bin.install "bale"
  end

  def caveats
    <<~EOS
      Start the sweep and hook your agent tools:
        bale install
        bale install --hooks claude
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/bale --version")
  end
end
