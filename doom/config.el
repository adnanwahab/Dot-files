;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(global-set-key "\C-x\C-m" 'execute-extended-command)
(map! "\C-x\C-m" #'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-c\m" 'execute-extended-command)
(global-set-key "\C-x\m" 'execute-extended-command)

;;asdfasdf asdfasd fads fsd

(global-set-key "\C-w" 'backward-kill-word)

;(global-set-key "\C-x\C-k" 'kill-region)

;;(global-set-key "\C-c\C-k" 'kill-region)
;;ask chatgpt -> combine these so that if i click C-W with a region highlighted then it kills the region
;;

(defun my-kill-region-or-backward-word ()
  "If a region is active and non-empty, kill the region. Otherwise, kill the word backward."
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(global-set-key "\C-w" 'my-kill-region-or-backward-word)


;;      https://github.com/minad/corfu?tab=readme-ov-file



;;apheleia for code formatting via prettier https://github.com/radian-software/apheleia
;;https://github.com/purcell/envrc
;;add-node-modules-to-path https://github.com/codesuki/add-node-modules-path
;;js-ts-mode, typescript-ts-mode, tsx-ts-mode via treesit-auto - https://github.com/renzmann/treesit-auto
;;eglot w/ tsserver
;;tide mode?
;;https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/
;;Emacs 29, tsx-ts-mode, eglot, flymake, flymake-eslint (not eslint-flymake)

;;https://old.reddit.com/r/emacs/comments/thll06/ann_tsxmodeel_a_batteriesincluded_major_mode_for/
;;I use jtsx-tsx-mode of jtsx package (I wroke it recently) + eglot. - https://github.com/llemaitre19/jtsx
;;
;;
;;https://github.com/doomemacs/doomemacs/issues/6172
;;
;;
;;
;; (use-package! tsx-mode
;;   :config
;;   (setq auto-mode-alist (delete '("\\.tsx\\'" . typescript-tsx-mode) auto-mode-alist))
;;   (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
;;   (set-formatter! 'tsx-prettier '("prettier" "--parser" "typescript") :modes '(tsx-mode)))
;;https://github.com/doomemacs/doomemacs/issues/6172
;;https://medium.com/@nedopaka/setup-a-react-vite-project-with-typescript-prettier-vitest-2024-9bb6e919ac8f
;;
;;
;;
;;
;;
;;6:30 - wake up
;;7:00 must leave house
;;7:15 get to lifetime
;;leave lifetime at 8
;;815



;;typescript + web
;;nix
;;
;;GO dev
;;C++ dev
;;;;android + kotlin ? lol

;https://www.reddit.com/r/emacs/comments/13god8v/how_do_i_improve_emacs_as_a_typescript_ide/
;;https://www.reddit.com/r/emacs/comments/13z8i1a/typescript_highlighting_in_emacs_incomplete/
;;https://www.reddit.com/r/emacs/comments/mgbejx/webmacs_new_emacs_configuration_for_web/
;; (global-set-key [(meta v)] 'revert-buffer-no-confirm) ;
;; (global-set-key [(meta o)] 'goto-line)
;; (global-set-key (kbd "M-p") 'iswitchb-buffer)
;; (global-set-key (kbd "M-i") 'gofmt)


;https://news.ycombinator.com/item?id=9600106
;;https://github.com/WeAreWizards/blog/blob/master/content/articles/ansible-and-nix.md
;;
;;
;;LSP mode - tailwind ??
;;prettier.js


;(add-to-list 'auto-mode-alist '("\\.jsx?$" . rjsx-mode))
;(add-to-list 'auto-mode-alist '("\\.tsx?$" . typescript-mode))


;;; Setup TypeScript Interactive Development Environment
;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   (company-mode +1))

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)
;; (add-hook 'js2-mode-hook #'setup-tide-mode)
;; (add-hook 'rjsx-mode-hook #'setup-tide-mode)


;;init.el
;:lang
;;(prettier +onsave)
;(typescript +lsp)
;:lang
;(web +lsp)
;
;;;emmet mode?
;;https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/
