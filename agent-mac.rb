class AgentMac < Formula
  desc "Headless macOS guests that agents drive and record, and people watch in a browser"
  homepage "https://github.com/bmcreations/agent-mac"
  url "https://github.com/bmcreations/agent-mac/releases/download/v0.3.0/agent-mac-0.3.0-arm64-apple-darwin.tar.gz"
  sha256 "4b4c29842e0e763036a18423982ce90608708be35e723a58d087e50cbfa0b79a"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sonoma
  depends_on "agent-desktop"
  depends_on "ffmpeg"

  def install
    # The release ships the runner built and signed with the virtualization
    # entitlement, and the guest's tools built, so nothing compiles.
    libexec.install "vm", "provision", "fps", "guest", "guest-bin", "agent-mac-runner"
    bin.install_symlink libexec/"vm" => "agent-mac"
    pkgshare.install "skills", "AGENTS.md", ".claude-plugin"
  end

  def caveats
    <<~EOS
      Guests, the restore image and the ssh key live in ~/.agent-mac
      (an existing ~/.agent-vm from agent-vm 0.2 moves there on first run).
      The first `agent-mac up` downloads about 25 GB, needs sudo for
      provisioning (run `sudo -v` first in an agent's shell), and builds the
      prepared guest new guests copy, about 10 minutes once.

      The agent skills are in #{opt_pkgshare}/skills. In Claude Code:
        /plugin marketplace add bmcreations/agent-mac
    EOS
  end

  test do
    assert_match "agent-desktop in the guest", shell_output("#{bin}/agent-mac help")
    assert_predicate libexec/"agent-mac-runner", :executable?
  end
end
