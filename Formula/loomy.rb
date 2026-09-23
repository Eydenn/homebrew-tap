# Formule Homebrew de Loomy. Le dépôt source est privé : Homebrew le clone avec Git,
# donc avec les identifiants GitHub de la machine (gh auth login).
class Loomy < Formula
  desc "Orchestre Codex et Claude Code : rôles routés par coût, journal, suivi terminal ou web"
  homepage "https://github.com/Eydenn/loomy"
  url "https://github.com/Eydenn/loomy.git",
      tag:      "v2.0.1",
      revision: "e08a30ab1fae4c1224b8818e6d21cfaf451f290a"
  version "2.0.1"
  head "https://github.com/Eydenn/loomy.git", branch: "main"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/loomy"
  end

  def caveats
    <<~EOS
      Vérifiez la machine avec :
        loomy doctor --fix --live
      Le tableau de bord web (loomy dashboard) nécessite Node >= 18 ou Bun.
    EOS
  end

  test do
    assert_match "loomy #{version}", shell_output("#{bin}/loomy version")
  end
end
