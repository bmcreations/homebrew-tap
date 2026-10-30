class Simcap < Formula
  desc "iOS simulator and iPhone helper that loupe streams and drives through"
  homepage "https://github.com/bmcreations/simcap"
  license "Apache-2.0"
  head "https://github.com/bmcreations/simcap.git", branch: "main"

  depends_on xcode: :build
  depends_on :macos

  def install
    # Built ad hoc. Streaming a physical iPhone needs simcap signed by your
    # team so the camera grant survives a rebuild; see caveats.
    system "make", "simcap"
    bin.install ".build/simcap"
  end

  def caveats
    <<~EOS
      loupe finds simcap on PATH and lists iOS simulators once it is there.
      Restart loupe after installing (brew services restart loupe).

      simcap loads private frameworks from your Xcode install, so an Xcode
      update can break it until it is rebuilt:
        brew reinstall --HEAD bmcreations/tap/simcap

      Physical iPhones need simcap signed by your Apple Development team;
      build it from a loupe checkout with `make simcap TEAM=<team id>`.
    EOS
  end

  test do
    assert_predicate bin/"simcap", :executable?
  end
end
