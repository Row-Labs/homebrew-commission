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
  version "0.1.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://commission.sh/download/v0.1.8/commission-darwin-arm64"
      sha256 "7ffa099a56f5c457503149e0ee2643f631a4a08ad7ca687ae83c83c54a103907"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.8/commission-darwin-x64"
      sha256 "620fe133b7e7801e5a8fbaaca8e6b40307a2377735f58fba5182676e0fbde391"
    end
  end

  on_linux do
    on_arm do
      url "https://commission.sh/download/v0.1.8/commission-linux-arm64"
      sha256 "46475febb6c586f389a08f298b59fd0573c38e5858fb2cc1c07cc8f915a10379"
    end
    on_intel do
      url "https://commission.sh/download/v0.1.8/commission-linux-x64"
      sha256 "2ccf78650d6e2635da731dd746f7e9612a6f153f79820d38691bebe186658202"
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
