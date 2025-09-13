;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Haluk Dogan"
      user-mail-address "hlk.dogan@gmail.com")

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
;; (setq doom-font (font-spec :family "RobotoMono Nerd Font" :size 13 :weight 'semi-light)
(setq doom-font (font-spec :family "Reddit Mono" :size 14 :weight 'regular)
     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13 :weight 'light))
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
(setq display-line-numbers-type nil)

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

;; literate config can start from here
;; keybindings
(load! "keybindings")

;; UI
;; (setq fancy-splash-image (concat doom-user-dir "assets/lambda-logo-white.png"))
(if (not (display-graphic-p))
    (setq doom-modeline-icon nil))  ;; Disable icons in terminal
;; (custom-set-faces
;;   '(mode-line ((t (:family "CaskaydiaCove Nerd Font Mono" :height 0.95))))
;;   '(mode-line-active ((t (:family "CaskaydiaCove Nerd Font Mono" :height 0.95)))) ; For 29+
;;   '(mode-line-inactive ((t (:family "CaskaydiaCove Nerd Font Mono" :height 0.95)))))
(add-hook! '+doom-dashboard-functions (hide-mode-line-mode 1))
;; ace-window font face
(custom-set-faces!
  '(aw-leading-char-face
    :foreground "white" :background "purple"
    :weight bold :height 2.5 :box (:line-width 10 :color "purple")))


(defun g-screenshot-on-buffer-creation ()
  (setq display-fill-column-indicator-column nil)
  (setq line-spacing nil))

(use-package screenshot

  :config
  (setq screenshot-line-numbers-p nil)

  (setq screenshot-min-width 80)
  (setq screenshot-max-width 80)
  (setq screenshot-truncate-lines-p nil)

  (setq screenshot-text-only-p nil)

  (setq screenshot-font-family "Reddit Mono")
  (setq screenshot-font-size 10)

  (setq screenshot-border-width 16)
  (setq screenshot-radius 0)

  (setq screenshot-shadow-radius 0)
  (setq screenshot-shadow-offset-horizontal 0)
  (setq screenshot-shadow-offset-vertical 0)

  :hook
  ((screenshot-buffer-creation-hook . g-screenshot-on-buffer-creation)))

;; RSS
(after! elfeed
  (setq elfeed-search-filter "@2-weeks-ago +unread")
  (setq elfeed-sort-order 'descending)
  (setq elfeed-search-title-max-width 100)
  (setq elfeed-search-title-min-width 30)
  (setq elfeed-search-trailing-width 25)
  (setq elfeed-show-truncate-long-urls t)
  (setq elfeed-goodies/entry-pane-position 'bottom))
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

;;Editor
(global-evil-matchit-mode 1)
(lsp-treemacs-sync-mode 1)

;; PL
(use-package uv-mode
  :hook (python-mode . uv-mode-auto-activate-hook))

;; hurl
(add-to-list 'auto-mode-alist '("\\.hurl\\'" . hurl-mode))

;; typescript
(after! ts-fold
  (setf (alist-get 'typescript-tsx-mode ts-fold-range-alist)
        (alist-get 'typescript-ts-mode ts-fold-range-alist)))

;; Tools
(defvar emms-mode-line-icon-color "white")

(after! lsp-mode
  (setq lsp-auto-guess-root t))

;; VCS
;; magit modeline branch refresh
(setq auto-revert-check-vc-info t)
(setq left-margin-width 0)

;; LLM
(defun llms-chat--api-key-from-auth-source (host)
  (when-let* ((api-key (auth-source-pick-first-password :host host :user "apikey")))
    (encode-coding-string api-key 'utf-8)))

;; Groq
(defvar llms-chat-gptel-groq-backend
  (gptel-make-openai "Groq"
    :host "api.groq.com"
    :endpoint "/openai/v1/chat/completions"
    :stream t
    :key (lambda () (llms-chat--api-key-from-auth-source "api.groq.com"))
    :models '(llama-3.3-70b-versatile
              llama-3.1-8b-instant
              llama3-70b-8192
              llama3-8b-8192
              mixtral-8x7b-32768
              gemma-7b-it)))

(setq gptel-backend llms-chat-gptel-groq-backend)
