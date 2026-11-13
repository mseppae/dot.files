"""Build the herdr and Neovim cheatsheet PDFs: python3 cheatsheets/build.py

Renders each sheet to HTML in a temp dir and prints it with headless Chrome or
Chromium. Update the key tables below when bindings change, then rerun.
"""
import html
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

OUT = Path(__file__).parent
CHROMES = [
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
    "/Applications/Chromium.app/Contents/MacOS/Chromium",
    "google-chrome",
    "google-chrome-stable",
    "chromium",
    "chromium-browser",
]

CSS = """
@page { size: A4 landscape; margin: 9mm 10mm; }
* { box-sizing: border-box; }
body { margin: 0; font: 8.1pt/1.28 -apple-system, "Helvetica Neue", Arial, sans-serif; color: #1d1d22; }
header { display: flex; align-items: baseline; gap: 10px; border-bottom: 2px solid #1d1d22; padding-bottom: 3px; margin-bottom: 6px; }
header h1 { font-size: 15pt; margin: 0; letter-spacing: -0.2px; }
header .sub { color: #55555f; font-size: 8.5pt; }
header .note { margin-left: auto; color: #55555f; font-size: 7.6pt; }
.cols { column-count: 4; column-gap: 9px; }
section { break-inside: avoid; border: 1px solid #c9c9d1; border-radius: 5px; padding: 4px 6px 5px; margin: 0 0 7px; }
section h2 { font-size: 8.8pt; margin: 0 0 3px; padding-bottom: 2px; border-bottom: 1px solid #e2e2e8; display: flex; justify-content: space-between; gap: 6px; }
section h2 span { font-weight: normal; color: #6a6a75; font-size: 7.3pt; }
table { border-collapse: collapse; width: 100%; }
td { vertical-align: top; padding: 1.2px 0; }
table { table-layout: fixed; }
td.k { padding-right: 6px; width: 41%; }
h3 { font-size: 7.4pt; text-transform: uppercase; letter-spacing: 0.5px; color: #6a6a75; margin: 4px 0 1px; }
kbd { font: 7.4pt/1 "SF Mono", Menlo, Consolas, monospace; background: #f1f1f5; border: 1px solid #c4c4cd; border-bottom-width: 2px; border-radius: 3px; padding: 1px 3px; display: inline-block; margin: 0 1px 1px 0; }
code { font: 7.3pt "SF Mono", Menlo, Consolas, monospace; background: #f1f1f5; border-radius: 2px; padding: 0 2px; }
.tip { color: #4a4a55; font-size: 7.5pt; margin: 3px 0 0; }
.flow { column-span: all; break-inside: avoid; border: 1px solid #1d1d22; border-radius: 5px; padding: 4px 7px; margin-bottom: 7px; background: #f7f7fa; }
.flow b { font-size: 8.4pt; }
.flow ol { margin: 2px 0 0; padding-left: 16px; display: flex; flex-wrap: wrap; gap: 2px 18px; }
"""


def keys(spec):
    """'prefix+t / j k' -> key caps. Words in {braces} stay plain text."""
    parts = []
    for token in re.split(r"(\s+/\s+|\s+|\{[^}]*\})", spec):
        if not token or token.isspace():
            continue
        if token.strip() == "/" and token != "/":
            parts.append('<span style="color:#888">/</span>')
        elif token.startswith("{"):
            parts.append(html.escape(token[1:-1]))
        else:
            parts.append(f"<kbd>{html.escape(token)}</kbd>")
    return " ".join(parts)


def inline(text):
    """`code` spans in descriptions."""
    out = html.escape(text)
    return re.sub(r"`([^`]+)`", r"<code>\1</code>", out)


def section(title, rows, hint=""):
    body = []
    for row in rows:
        if isinstance(row, str):
            if row.startswith("##"):
                body.append(f"</table><h3>{html.escape(row[2:].strip())}</h3><table>")
            else:
                body.append(f'</table><p class="tip">{inline(row)}</p><table>')
            continue
        k, desc = row
        if k.startswith("$ "):
            # A command, not keys: full width so long ones wrap instead of overflowing.
            text = f" — {inline(desc)}" if desc else ""
            body.append(f'<tr><td colspan="2"><code>{html.escape(k[2:])}</code>{text}</td></tr>')
            continue
        body.append(f'<tr><td class="k">{keys(k)}</td><td>{inline(desc)}</td></tr>')
    h = f"<span>{html.escape(hint)}</span>" if hint else ""
    return f'<section><h2>{html.escape(title)}{h}</h2><table>{"".join(body)}</table></section>'


def page(title, sub, note, flow, sections):
    steps = "".join(f"<li>{inline(s)}</li>" for s in flow[1])
    return f"""<!doctype html><html><head><meta charset="utf-8"><title>{html.escape(title)}</title>
<style>{CSS}</style></head><body>
<header><h1>{html.escape(title)}</h1><span class="sub">{inline(sub)}</span><span class="note">{inline(note)}</span></header>
<div class="cols"><div class="flow"><b>{html.escape(flow[0])}</b><ol>{steps}</ol></div>
{"".join(sections)}</div></body></html>"""


HERDR = page(
    "herdr cheatsheet",
    "prefix = `Ctrl+b` · plugins: Navigator, reviewr, herdr-nvim",
    "In-app help: `prefix+?` herdr · `?` Navigator · `?` reviewr",
    ("Review loop", [
        "Start: `claude --worktree <name>`",
        "Find an agent: `prefix+t` then `a` and type, or `@idle`",
        "Review: `prefix+d`, then `t` for the last turn",
        "Comment: `v` select, `c` comment, repeat",
        "Send: `s`, then press Enter in the agent",
        "Fix it yourself: `e` opens Neovim at the line",
    ]),
    [
        section("Plugin keys", [
            ("prefix+t", "Navigator: jump to anything"),
            ("prefix+d", "reviewr: toggle the diff review pane"),
            ("prefix+f", "herdr-nvim: open a file the agent touched"),
            ("prefix+shift+e", "herdr-nvim: toggle the Neovim sidebar"),
            ("Ctrl {+} click", "a file path in agent output opens it in the sidebar"),
            "Navigator side pane and jump-back have no key; see CLI below.",
        ], "custom"),
        section("herdr-nvim (herdr side)", [
            ("prefix+shift+e", "sidebar: one persistent Neovim per tab"),
            ("prefix+f", "picker: agent-touched files first; type to search the repo"),
            ("Enter", "open the file in the sidebar at the line"),
            "Comment keys inside Neovim: `<Space>hc` `hs` `hS` `hl` `hi` (see the Neovim sheet).",
            "## Daemon CLI",
            "Binary: `~/.local/share/herdr-nvim/bin/herdr-nvim`",
            ("$ daemons", "list per-tab Neovims, RAM, unsaved work"),
            ("$ daemons stop <tab>", "stop one (`--force` drops unsaved)"),
            ("$ daemons stop --orphans", "stop daemons whose tab is gone"),
            ("$ doctor", "live health checks"),
        ]),
        section("herdr core", [
            ("prefix+?", "keybinding help"),
            ("prefix+s", "settings"),
            ("prefix+g", "go to any agent/terminal (`/` search, `j` `k`)"),
            ("prefix+w", "workspace navigation"),
            ("prefix+b", "toggle sidebar"),
            ("prefix+o", "focus notification target"),
            "## Workspaces and tabs",
            ("prefix+shift+n", "new workspace"),
            ("prefix+shift+g", "new git worktree"),
            ("prefix+shift+w", "rename workspace"),
            ("prefix+shift+d", "close workspace"),
            ("prefix+c", "new tab"),
            ("prefix+n / prefix+p", "next / previous tab"),
            ("prefix+1…9", "switch to tab"),
            ("prefix+shift+t", "rename tab"),
            ("prefix+shift+x", "close tab"),
            "## Panes",
            ("prefix+v / prefix+minus", "split vertical / horizontal"),
            ("prefix+h/j/k/l", "focus pane"),
            ("prefix+shift+h", "swap pane left (also shift+j/k/l)"),
            ("prefix+z", "zoom"),
            ("prefix+r", "resize mode"),
            ("prefix+x", "close pane"),
            ("prefix+shift+p", "rename pane"),
            ("prefix+[", "copy mode (`v` select, `y` copy, `/` search)"),
            ("prefix+e", "scrollback in $EDITOR"),
            ("prefix+shift+r", "reload config"),
            ("prefix+q", "detach"),
        ], "defaults"),
        section("Navigator", [
            "## Normal mode (vim_mode on)",
            ("j / k", "move"),
            ("Enter", "open: focus, or create a workspace"),
            ("/", "search everything"),
            ("w a p q", "filter: workspaces, agents, projects, quick actions"),
            ("s l z r", "filter: remotes, sessions, zoxide dirs, roots"),
            ("{same letter}", "again: back to all sources"),
            ("Tab", "cycle source filters"),
            ("Esc", "search → normal; normal → close"),
            "## Any mode",
            ("Ctrl+w / Ctrl+a {…}", "switch source, keep typed text"),
            ("Ctrl+u", "clear text and filter"),
            ("Ctrl+x", "close the workspace matching the item"),
            ("Ctrl+b", "pin / unpin item"),
            ("Ctrl+o", "show / hide preview (starts hidden)"),
            ("Alt+Enter", "open a dir with the project template"),
            ("?", "all keys"),
            "## Search syntax",
            ("!claude", "agent name"),
            ("@idle", "agent status (also @working, @blocked)"),
            ("@dot.files", "workspace label"),
            ("/dotfiles", "folder path"),
            "With nothing typed, the previous workspace is listed first: `prefix+t` `Enter` goes back.",
        ], "prefix+t"),
        section("reviewr: scope and view", [
            ("u b t g", "scope: uncommitted, branch, last turn, commits"),
            ("1 2 3", "tab: Changes, All files, PR"),
            ("B", "pick base branch"),
            ("G", "pick commits"),
            ("W", "switch worktree"),
            ("|", "unified / side-by-side (137+ cols)"),
            ("w", "wrap lines"),
            ("m", "rendered / source Markdown"),
            ("z", "hide / show file list"),
            ("p", "move file list"),
            ("< / >", "widen / narrow file list"),
            ("r", "refresh"),
            "## Move",
            ("j / k", "line"),
            ("] / [", "next / previous change"),
            ("f / F", "next / previous file"),
            ("Ctrl+d / Ctrl+u", "half page"),
            ("Tab", "switch pane"),
            ("/", "search files and code"),
            ("Ctrl+f", "find in file"),
            (":", "go to line (`:0` first, `:$` last)"),
        ], "prefix+d"),
        section("reviewr: comment and send", [
            ("v", "select lines"),
            ("c", "comment"),
            ("e", "edit comment, or open file in Neovim"),
            ("d", "delete comment"),
            ("n / N", "next / previous comment"),
            ("l", "list comments"),
            ("s", "send all to the agent's input (never submits)"),
            ("y", "copy comments"),
            ("Esc", "clear selection"),
            "## Comment box",
            ("Enter", "save"),
            ("Esc", "cancel"),
            ("Shift+Enter / Ctrl+j", "new line"),
            "## Quit",
            ("q", "quit (asks if comments are unsent)"),
            ("Q", "quit and drop unsent comments"),
            ("?", "all keys"),
            "PR tab: `j` `k` move, `o` open in browser. Comments work on deleted lines too.",
        ], "prefix+d"),
        section("CLI", [
            ("$ herdr plugin list", "installed plugins"),
            ("$ herdr server reload-config", "apply config changes"),
            ("$ herdr config check", "validate config.toml"),
            ("$ herdr plugin action invoke herdr-navigator.open-side", "Navigator as a side pane"),
            ("$ herdr plugin action invoke herdr-navigator.jump-back", "previous workspace"),
            ("$ herdr integration status", "agent hooks (Claude: current)"),
        ]),
    ],
)

NVIM = page(
    "Neovim cheatsheet",
    "leader = `Space` · localleader = `\\`",
    "`:Telescope keymaps` fuzzy-searches every mapping · herdr-nvim keys only inside herdr panes",
    ("Review an agent's change", [
        "`e` in herdr-reviewr opens the file; signs mark the branch's changes",
        "`grr` `gd` to read the code around it",
        "`V` select, `<Space>hc` comment",
        "`<Space>hs` paste all notes into the agent",
    ]),
    [
        section("Basics", [
            ("jk", "leave insert mode"),
            ("Esc", "clear search highlight"),
            ("<Space>S", "save and source the file"),
            ("<Space>y / <Space>p / <Space>P", "system clipboard: yank, paste after/before"),
            ("gx", "open URL under cursor"),
            ("gX", "open every URL on the line (or selection)"),
            ("<Space>pu", "update plugins (:Lazy update)"),
            "Arrow keys are disabled in normal, insert and visual mode.",
            "## Terminal mode",
            ("Ctrl+u / Ctrl+d", "scroll half page"),
            ("Ctrl+b / Ctrl+f", "page up / down"),
        ]),
        section("Windows", [
            ("Ctrl+h/j/k/l", "move between splits, also across Ghostty splits"),
        ], "smart-splits"),
        section("Comment to the agent", [
            ("<Space>hc", "comment line, or selection in visual mode"),
            ("<Space>hl", "list comments (`Enter` edit, `d` delete)"),
            ("<Space>hs", "paste all comments into the agent's input"),
            ("<Space>hS", "send all comments and submit"),
            ("<Space>hi", "insert a `path:line` reference at the agent"),
            "Also `:Herdr comment|list|send|submit|ref`, with ranges like `:5,10Herdr comment`. Loaded only inside herdr panes.",
        ], "herdr-nvim"),
        section("Find", [
            ("<Space>sf", "files"),
            ("<Space>s.", "recent files (this project)"),
            ("<Space>sg", "live grep (with rg args)"),
            ("<Space>sw", "grep word under cursor / selection"),
            ("<Space>sr", "resume last search"),
            ("<Space>sh", "help tags"),
            ("<Space><Space>", "open buffers"),
            "## In a picker",
            ("Ctrl+n / Ctrl+p", "next / previous result"),
            ("Ctrl+x / Ctrl+v / Ctrl+t", "open in split / vsplit / tab"),
            ("Ctrl+q", "send results to quickfix"),
            ("Esc", "normal mode (`j` `k`, `Esc` again closes)"),
        ], "telescope"),
        section("Jump", [
            ("s", "flash: jump to any visible spot"),
            ("S", "flash: select a treesitter node"),
            ("r", "remote: act elsewhere, e.g. `yr`"),
            ("R", "treesitter search (operator/visual)"),
            ("Ctrl+s", "in `/` search: toggle flash labels"),
        ], "flash"),
        section("Undo history", [
            ("<Space>a", "toggle the undo tree"),
            ("j / k", "older / newer state"),
            ("Enter", "undo to this state"),
            ("q", "close"),
            ("?", "help"),
        ], "atone"),
        section("Code (LSP)", [
            ("gd / gD", "definition / declaration"),
            ("K", "hover"),
            ("grr", "references"),
            ("gri", "implementation"),
            ("grt", "type definition"),
            ("grn", "rename"),
            ("gra", "code action"),
            ("gO", "document symbols"),
            ("Ctrl+s", "signature help (insert mode)"),
            ("<Space>uh", "toggle inlay hints"),
            ("<Space>f", "format buffer (also on save)"),
            "## Completion (pops up while typing)",
            ("Ctrl+n / Ctrl+p", "next / previous item"),
            ("Ctrl+y", "accept"),
            ("Ctrl+e", "dismiss"),
            ("Ctrl+x Ctrl+o", "ask for completion"),
            "## Diagnostics",
            ("]d / [d", "next / previous"),
            ("Ctrl+w d", "show diagnostic at cursor"),
            ("<Space>q", "all diagnostics to location list"),
        ], "lua go ruby ts zig odin"),
        section("Project trust", [
            ("$ :Trust [dir]", "allow LSP servers and formatters here"),
            ("$ :Untrust [dir]", "revoke"),
            ("$ :TrustList", "list trusted projects"),
            "Untrusted projects get no LSP and no format-on-save, because both can run project code.",
        ]),
        section("Git", [
            ("<Space>gh", "history of this file (visual: of the selected lines)"),
            "## In the history picker",
            ("Enter", "diff against that commit, in a new tab"),
            ("Ctrl+v / Ctrl+x", "the same diff in a vertical / horizontal split"),
            ("$ :tabclose", "close the diff tab"),
            "Signs show everything the branch changed, from herdr-reviewr's base; on the default branch, uncommitted changes. Blame at line end; `:Gitsigns preview_hunk`, `next_hunk`.",
        ]),
        section("Files", [
            ("\\", "neo-tree: reveal current file / close"),
            "## In the tree",
            ("a", "add (end with / for a folder)"),
            ("d / r", "delete / rename"),
            ("m / c", "move / copy"),
            ("H", "toggle hidden files"),
            ("/", "filter"),
            ("?", "all keys"),
        ], "neo-tree"),
    ],
)



def find_chrome():
    for candidate in CHROMES:
        found = candidate if Path(candidate).exists() else shutil.which(candidate)
        if found:
            return found
    sys.exit("No Chrome or Chromium found to print the PDFs.")


def main():
    chrome = find_chrome()
    with tempfile.TemporaryDirectory() as tmp:
        for name, doc in (("herdr", HERDR), ("neovim", NVIM)):
            src = Path(tmp) / f"{name}.html"
            src.write_text(doc)
            pdf = OUT / f"{name}-cheatsheet.pdf"
            subprocess.run(
                [chrome, "--headless=new", "--disable-gpu", "--no-pdf-header-footer",
                 f"--print-to-pdf={pdf}", src.as_uri()],
                check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
            )
            print("wrote", pdf)


if __name__ == "__main__":
    main()
