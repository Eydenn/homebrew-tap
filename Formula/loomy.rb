class Loomy < Formula
  desc "AI development team, orchestrated: Claude Code and Codex on your projects"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy/archive/refs/tags/v0.17.2.tar.gz"
  sha256 "8b988550b5546136dd38266840e8e26fd104ef63d8a42c9cb29e007b42ad97eb"
  license "Apache-2.0"
  head "https://github.com/Eydenn/loomy.git", branch: "main"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/loomy"
  end

  def caveats
    <<~EOS
      Check the machine with:
        loomy doctor --fix --live
      Then create a project:
        loomy init
    EOS
  end

  test do
    assert_match "loomy #{version}", shell_output("#{bin}/loomy version")
  end
end
