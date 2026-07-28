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
  version "0.1.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://commission.sh/download/v0.1.5/commission-darwin-arm64"
      sha256 "995ee0748a875ef733cae3d96e5b8fe642b3fd01b4bd717a93178c4862da5b3a"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.5/commission-darwin-x64"
      sha256 "e135a2c58daca325a6b3ba4f278a893962f2cae6640c2cdb7caa541d181d318a"
    end
  end

  on_linux do
    on_arm do
      url "https://commission.sh/download/v0.1.5/commission-linux-arm64"
      sha256 "3e3291952474d75115c26675cf3af915846ca71ce7a4854c96adfa483545e822"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.5/commission-linux-x64"
      sha256 "7808f9473aef9de7ab7fbfc4fdbb80f33e8785281dfe1bef43a1a6bf2a73cd8b"
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
