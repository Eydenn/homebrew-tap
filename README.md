# Tap Homebrew d'Eydenn

```bash
HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)" brew install eydenn/tap/loomy
```

| Formule | Description |
|---|---|
| `loomy` | Orchestre Codex et Claude Code : rôles routés par coût, journal, suivi en direct dans le terminal. |

Les dépôts sources sont privés. Homebrew télécharge dans un bac à sable qui n'a pas accès au trousseau macOS : le jeton GitHub lui est transmis par `HOMEBREW_GITHUB_API_TOKEN`, le temps du téléchargement seulement (rien n'est écrit sur le disque). `gh auth token` le fournit si vous êtes connecté avec `gh auth login`.
