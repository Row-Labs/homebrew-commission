# Homebrew formula for Commission. Generated on release by
# scripts/release-notes.ts — do not hand-edit the copy in the tap.
#
# A cask would be wrong here: this is a CLI, not an app bundle. A
# build-from-source formula would also be wrong — the source is private, and
# homebrew-core will not take a proprietary formula, which is why this lives in
# a tap of its own.
class Commission < Formula
  desc "The execution layer for software delivery"
  homepage "https://commission.sh"
  version "0.1.6"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://commission.sh/download/v0.1.6/commission-darwin-arm64"
      sha256 "7d287cd55c6a41723bd4d79c4759c51816f84e70142a8b40beccc85dc926a10d"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.6/commission-darwin-x64"
      sha256 "a71ec70f078172e266d959d78e3e95bbd822d2bcaf0a7b277d7edfbb0e4611ec"
    end
  end

  on_linux do
    on_arm do
      url "https://commission.sh/download/v0.1.6/commission-linux-arm64"
      sha256 "1481146581f60a1a95b321d2fc0fb51119558410a04992a457460fa1160395f7"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.6/commission-linux-x64"
      sha256 "1bd51d888a13f0dd6ed95e5b8771b2a29fe1bbc29444057721f163f7a8f83629"
    end
  end

  def install
    bin.install Dir["commission-*"].first => "commission"
  end

  def caveats
    <<~EOS
      Commission is licensed. A person signs in once on this machine and every
      agent on it inherits the licence:

        commission login
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/commission --version")
    # An unlicensed binary must refuse cleanly rather than crash: exit 2, in
    # Commission's refusal shape. `brew test` runs with no licence, which makes
    # this the honest thing to assert here.
    output = shell_output("COMMISSION_STRICT_AUTH=1 #{bin}/commission board 2>&1", 2)
    assert_match "licensed", output
  end
end
