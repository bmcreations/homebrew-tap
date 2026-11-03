class Bale < Formula
  desc "Keeps agent worktrees from filling your disk"
  homepage "https://github.com/bmcreations/bale"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.1/bale-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "9b0db839325f0fa17be12d7d47fb1c0258d06396e7a66fd199504a063849f143"
    end
    on_intel do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.1/bale-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "85730ca1524080ad020714634cb39d9c1f324230d9b34e6de36a0834ac62f790"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.1/bale-v0.2.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "13ce7f9a0416cb8026f64928398b8b2accac4732a945979082be58cf8f6ebf81"
    end
    on_intel do
      url "https://github.com/bmcreations/bale/releases/download/v0.2.1/bale-v0.2.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1af7be8e51dde59d356706b2177b02bc8c736365b1c01d9b387a25d68cf96a23"
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
