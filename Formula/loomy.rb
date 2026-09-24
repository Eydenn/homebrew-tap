# Formule Homebrew de Loomy. Le dépôt source est privé : Homebrew le clone avec Git,
# donc avec les identifiants GitHub de la machine (gh auth login).
class Loomy < Formula
  desc "Orchestre Codex et Claude Code : rôles routés par coût, journal, suivi terminal"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy.git",
      tag:      "v0.1.0",
      revision: "0548a692527e6b06b5b7f50032ce234cac360655"
  version "0.1.0"
  head "https://github.com/Eydenn/loomy.git", branch: "main"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/loomy"
  end

  def caveats
    <<~EOS
      Vérifiez la machine avec :
        loomy doctor --fix --live
      Suivi en direct d'un projet :
        loomy watch
    EOS
  end

  test do
    assert_match "loomy #{version}", shell_output("#{bin}/loomy version")
  end
end
